#!/bin/bash

result=$(ps ax|grep -v grep|grep picom)

if [ "$result" == "" ]; then
  eval "picom -b"
  notify-send "compositor on" &
else
  eval "killall picom"
  notify-send "compositor off" &
fi
