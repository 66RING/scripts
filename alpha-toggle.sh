#!/bin/bash

result=$(ps ax|grep -v grep|grep picom)

if [ -z "$result" ]; then
  eval "picom -b --experimental-backends"
  bspc config border_width         0
  notify-send "compositor on" &
else
  eval "killall picom"
  bspc config border_width         5
  notify-send "compositor off" &
fi
