#!/usr/bin/python
# coding=utf-8

import requests
import re
import sys

def main():

    URL= "http://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule"
    Str = " ".join(sys.argv[1:])
    Strend = ""
    resStr = '\"tgt\"\:\"(.*?)\"\}'
    data = {
        "i":Str,
        "from":"AUTO",    
        "to":"AUTO",
        "doctype":"json"
    }
    if Str != '':
        res = requests.post(url = URL,data = data)
        res = res.content.decode("utf-8")
        StrJson = re.findall(resStr,res,re.S)
        for str in StrJson:
            Strend += str
        print(Strend)

main()
