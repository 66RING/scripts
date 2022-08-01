#!/bin/env python
import _thread
import requests
import time
from bilibili_api import live, sync


roomid = 492006

def send_msg(msg, roomid = 492006):
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
        "csrf": "e716372b3b6f26add21a0cfbe5dbf781",
        "csrf_token": "e716372b3b6f26add21a0cfbe5dbf781",
    }
    headers = {
        "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36",
        "cookie": "_uuid=9DD97BA10-9C810-EEF10-D16E-421ECC558C3C78318infoc; b_nut=1642212379; buvid3=47106162-4226-4A65-B64F-27545C895D17167626infoc; rpdid=|(um|)m~~uYl0J'uYRkkukJY|; i-wanna-go-back=-1; LIVE_BUVID=AUTO6516428274160830; buvid4=24E141A4-DCCF-4495-0677-FB51903F016E79647-022012423-9MOWRiZxYVUCdVApH/4FaA%3D%3D; buvid_fp_plain=undefined; DedeUserID=12363255; DedeUserID__ckMd5=40423eebf30c2038; b_ut=5; buvid_fp=c23e249b211d71e8ca2972a8d7cdf822; CNZZDATA1256793290=861216216-1644890239-https%253A%252F%252Fwww.daimajiaoliu.com%252F%7C1644890239; CURRENT_BLACKGAP=0; nostalgia_conf=-1; hit-dyn-v2=1; fingerprint3=9535d9100c33035fdc5d01d5c8160291; fingerprint=fbde0be86454d110989c1c36641d86b9; blackside_state=0; bsource=search_google; SESSDATA=fc1d3a91%2C1674465811%2C363f7%2A71; bili_jct=e716372b3b6f26add21a0cfbe5dbf781; sid=7mvb9dj9; CURRENT_QUALITY=0; bp_video_offset_12363255=689302857574252500; b_lsid=59CC421B_18257E479A6; CURRENT_FNVAL=4048; _dfcaptcha=61a49197267f37f5d12963d8eda8d8cb; Hm_lvt_8a6e55dbd2870f0f5bc9194cddf32a02=1659335299; innersign=0; b_timer=%7B%22ffp%22%3A%7B%22333.1007.fp.risk_47106162%22%3A%2218258167F14%22%2C%22333.788.fp.risk_47106162%22%3A%221825816CDC0%22%2C%22333.934.fp.risk_47106162%22%3A%2218257DC44DC%22%2C%22333.999.fp.risk_47106162%22%3A%2218258256CC4%22%2C%22333.337.fp.risk_47106162%22%3A%2218251F7E7C7%22%2C%22444.41.fp.risk_47106162%22%3A%221825467FF14%22%2C%22333.976.fp.risk_47106162%22%3A%2218257C65525%22%2C%22666.25.fp.risk_47106162%22%3A%2218234FC0585%22%2C%22555.120.fp.risk_47106162%22%3A%221823E11A677%22%2C%22777.5.0.0.fp.risk_47106162%22%3A%2218257DCEAC6%22%2C%22888.2421.fp.risk_47106162%22%3A%2218249C711F0%22%2C%22444.8.fp.risk_47106162%22%3A%221825816EBBA%22%7D%7D; PVID=2; Hm_lpvt_8a6e55dbd2870f0f5bc9194cddf32a02=1659336343",
        "origin": "https://live.bilibili.com",
    }
    res = requests.post(url=url, headers=headers, data = post_data)


if __name__ == "__main__":

    room = live.LiveDanmaku("%d" % roomid)
    # room.logger.disabled = True
    @room.on("DANMU_MSG")
    async def get_msg(event):
        info = event["data"]["info"]
        msg = info[1]
        user = info[2][1]
        print("%s: %s" % (user, msg))

    @room.on('SEND_GIFT')
    async def get_gift(event):
        info = event["data"]["info"]
        msg = info[1]
        user = info[2][1]
        print("🌟%s: %s" % (user, msg))

    # sync(room.connect())

    _thread.start_new_thread(sync, (room.connect(),))

    while True:
        msg = input("\r")
        send_msg(msg)



