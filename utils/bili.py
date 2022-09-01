#!/bin/env python
from textual.app import App
from rich.panel import Panel
from textual.reactive import Reactive
from textual.widget import Widget
import _thread
import requests
import time
from bilibili_api import live, sync
import os
import warnings


roomid = 492006
cookie = "_uuid=9DD97BA10-9C810-EEF10-D16E-421ECC558C3C78318infoc; b_nut=1642212379; buvid3=47106162-4226-4A65-B64F-27545C895D17167626infoc; rpdid=|(um|)m~~uYl0J'uYRkkukJY|; i-wanna-go-back=-1; LIVE_BUVID=AUTO6516428274160830; buvid4=24E141A4-DCCF-4495-0677-FB51903F016E79647-022012423-9MOWRiZxYVUCdVApH/4FaA%3D%3D; buvid_fp_plain=undefined; DedeUserID=12363255; DedeUserID__ckMd5=40423eebf30c2038; b_ut=5; buvid_fp=c23e249b211d71e8ca2972a8d7cdf822; CNZZDATA1256793290=861216216-1644890239-https%253A%252F%252Fwww.daimajiaoliu.com%252F%7C1644890239; CURRENT_BLACKGAP=0; nostalgia_conf=-1; hit-dyn-v2=1; fingerprint3=9535d9100c33035fdc5d01d5c8160291; fingerprint=fbde0be86454d110989c1c36641d86b9; blackside_state=0; bsource=search_google; CURRENT_QUALITY=0; Hm_lvt_8a6e55dbd2870f0f5bc9194cddf32a02=1659335299; SESSDATA=c328b3ec%2C1674898587%2C717ec%2A81; bili_jct=35189d2d18b9dfe91df661fd4e3e41a8; sid=8fqhqvcc; bp_video_offset_12363255=690093269198045300; innersign=0; CURRENT_FNVAL=80; PVID=2; b_timer=%7B%22ffp%22%3A%7B%22333.1007.fp.risk_47106162%22%3A%22182631D8458%22%2C%22333.788.fp.risk_47106162%22%3A%221826298C988%22%2C%22333.934.fp.risk_47106162%22%3A%2218262B551EA%22%2C%22333.999.fp.risk_47106162%22%3A%22182631D9D08%22%2C%22333.337.fp.risk_47106162%22%3A%2218261DCADF9%22%2C%22444.41.fp.risk_47106162%22%3A%221825EE7009B%22%2C%22333.976.fp.risk_47106162%22%3A%2218257C65525%22%2C%22666.25.fp.risk_47106162%22%3A%2218234FC0585%22%2C%22555.120.fp.risk_47106162%22%3A%221823E11A677%22%2C%22777.5.0.0.fp.risk_47106162%22%3A%2218257DCEAC6%22%2C%22888.2421.fp.risk_47106162%22%3A%2218249C711F0%22%2C%22444.8.fp.risk_47106162%22%3A%22182631DB7EA%22%2C%22888.70908.fp.risk_47106162%22%3A%2218258ACA8DA%22%2C%22444.7.fp.risk_47106162%22%3A%221825EE715A7%22%7D%7D; Hm_lpvt_8a6e55dbd2870f0f5bc9194cddf32a02=1659520486; b_lsid=26C67889_1826332D8E0"
user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36"
csrf = "35189d2d18b9dfe91df661fd4e3e41a8"
csrf_token = "35189d2d18b9dfe91df661fd4e3e41a8"



class TextInput(Widget):
    text = Reactive("")

    def render(self) -> Panel:
        return f"[b]>[/b] {self.text}"
        # return Panel(f"[b]>[/b] {self.text}", style=(""))

class Messages(Widget):
    messages = Reactive([])
    update = Reactive(False)

    def render(self) -> Panel:
        """Render the Messages Panel"""
        self.update = False
        return f"{self._message_string()}"
        # return Panel(f"{self._message_string()}")

    def _message_string(self):
        return "\n".join([f"{message}" for message in self.messages])


class ChatApp(App):
    text = ""
    messages = None
    text_input = None
    inp_size = 2
    msg_size = os.get_terminal_size().lines - inp_size

    async def on_mount(self) -> None:
        self.set_interval(1, self.refresh)
        self.messages = Messages()
        self.text_input = TextInput()
        await self.view.dock(self.messages, size=self.msg_size, edge="top")
        await self.view.dock(self.text_input, size=self.inp_size)
        room = live.LiveDanmaku("%d" % roomid)
        # room.logger.disabled = True

        @room.on("DANMU_MSG")
        async def get_msg(event):
            info = event["data"]["info"]
            msg = info[1]
            user = info[2][1]
            self.income_msg("%s: %s" % (user, msg))

        @room.on('SEND_GIFT')
        async def get_gift(event):
            data = event["data"]["data"]
            giftname = data["giftName"]
            user = data["uname"]
            self.income_msg("🌟%s: %s" % (user, giftname))

        # sync(room.connect())
        _thread.start_new_thread(sync, (room.connect(),))

    async def on_key(self, event):
        """fires when a key is pressed"""
        self._handle_key(event.key)

    def _handle_key(self, key):
        if key == 'ctrl+h': # delete, in case of
            if len(self.text) > 0:
                self.text = self.text[:-1]

        elif key == 'enter':
            # self.income_msg(self.text)
            self.send_msg(self.text)
            self.text = ""

        else:
            self.text += str(key)
        self.text_input.text = self.text

    def income_msg(self, msg):
        self.messages.messages.append(msg)
        self.messages.messages = self.messages.messages[-(self.msg_size-1):]
        self.messages.update = True


    def send_msg(self, msg, roomid = 492006):
        url = 'https://api.live.bilibili.com/msg/send'
        t = int(time.time())

        post_data = {
            "bubble": "0",
            "msg": msg,
            "color": "16777215",
            "mode": "1",
            "fontsize": "25",
            "rnd": "%d" % t,
            "roomid": roomid,
            "csrf": csrf,
            "csrf_token": csrf_token
        }
        headers = {
            "user-agent": user_agent,
            "cookie": cookie,
            "origin": "https://live.bilibili.com",
        }
        res = requests.post(url=url, headers=headers, data = post_data)


if __name__ == "__main__":
    warnings.simplefilter('ignore', ResourceWarning)
    ChatApp.run()

