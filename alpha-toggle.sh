#!/bin/bash

result=$(ps ax|grep -v grep|grep picom)

echo $result
if [ "$result" == "" ]; then
  eval "picom --config ~/.config/picom.conf -b"
  notify-send "compositor on" &
else
  eval "killall picom"
  notify-send "compositor off" &
fi
