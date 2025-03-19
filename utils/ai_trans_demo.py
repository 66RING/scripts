#!/usr/bin/python
# coding=utf-8

import requests
import sys
import json
import hashlib
import random
import time
import requests


def parse_page(res):
    data = json.loads(res)
    return data


def get_page_index(Str):
    URL= "https://aidemo.youdao.com/trans"
    data = {
        "q":Str,
        "from":"AUTO",    
        "to":"AUTO",
    }

    res = requests.post(url=URL, data=data)
    res = res.content.decode("utf-8")
    return res


# def main():

#     Str = ' '.join(sys.argv[1:])

#     if Str == '':
#         Str = sys.stdin.read().strip('\n')

#     res = get_page_index(Str)
#     items = parse_page(res)

#     print(items.get('translation')[0])
#     if items.get('web'):
#         print('\n')
#         for item in items.get('web'):
#             print(', '.join(item.get('value')))


def send_request(content):
    salt = str(round(time.time() * 1000)) + str(random.randint(0, 9))
    data = "fanyideskweb" + content + salt + "Tbh5E8=q6U3EXe+&L[4c@"
    sign = hashlib.md5()
    sign.update(data.encode("utf-8"))
    sign = sign.hexdigest()

    url = 'http://fanyi.youdao.com/translate_o?smartresult=dict&smartresult=rule'
    headers = {
        'Cookie': 'OUTFOX_SEARCH_USER_ID=-1927650476@223.97.13.65;',
        'Host': 'fanyi.youdao.com',
        'Origin': 'http://fanyi.youdao.com',
        'Referer': 'http://fanyi.youdao.com/',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.146 Safari/537.36',
    }
    data = {
        'i': str(content),
        'from': 'AUTO',
        'to': 'AUTO',
        'smartresult': 'dict',
        'client': 'fanyideskweb',
        'salt': str(salt),
        'sign': str(sign),
        'version': '2.1',
        'keyfrom': 'fanyi.web',
        'action': 'FY_BY_REALTlME',
    }

    res = requests.post(url=url, headers=headers, data=data).json()
    return res['translateResult'][0][0]['tgt']

def main():
    content = ' '.join(sys.argv[1:])
    if content == '':
        content = sys.stdin.read().strip('\n')

    result = send_request(content)
    print(result)


if __name__ == "__main__":
    main()
