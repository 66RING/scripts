#!/bin/bash

#xrandr --auto --output HDMI1 --same-as eDP1 --size 1920x1080
xrandr --output eDP --scale 0.8x0.8 &
# xrandr --output DisplayPort-0 --primary --size 1920x1080 --output eDP --off
# ~/scripts/dwm/dwm-status.sh &
~/scripts/wp-autochange.sh &
picom -b &

~/scripts/tap-to-click.sh &
~/scripts/inverse-scroll.sh &
# xss-lock slock &
xset r rate 250 30 &
nm-applet &
# ~/scripts/run-mailsync.sh &
~/scripts/autostart_wait.sh &
