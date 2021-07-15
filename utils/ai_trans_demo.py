#!/usr/bin/python
# coding=utf-8

import requests
import sys
import json


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


def main():

    Str = ' '.join(sys.argv[1:])

    if Str == '':
        Str = sys.stdin.read().strip('\n')

    res = get_page_index(Str)
    items = parse_page(res)

    print(items.get('translation')[0])
    if items.get('web'):
        print('\n')
        for item in items.get('web'):
            print(', '.join(item.get('value')))



if __name__ == "__main__":
    main()
