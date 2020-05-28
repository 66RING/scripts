#!/bin/bash

result=$(ps ax|grep -v grep|grep xcompmgr)

echo $result
if [ "$result" == "" ]; then
  #eval "picom --config ~/.config/picom.conf -b"
  eval "xcompmgr -c -o.55 -IO &"
  notify-send "compositor on" &
else
  #eval "killall picom"
  eval "killall xcompmgr"
  notify-send "compositor off" &
fi
