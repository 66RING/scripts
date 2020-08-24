#!/bin/bash

#xrandr --auto --output HDMI1 --same-as eDP1 --size 1920x1080
xrandr --output eDP --scale 0.8x0.8 &
# xrandr --output DisplayPort-0 --primary --size 1920x1080 --output eDP --off
# /bin/bash ~/scripts/dwm/dwm-status.sh &
/bin/bash ~/scripts/wp-autochange.sh &
picom -b --experimental-backends &

/bin/bash ~/scripts/tap-to-click.sh &
/bin/bash ~/scripts/inverse-scroll.sh &
xss-lock slock &
xset r rate 250 30 &
nm-applet &
#/bin/bash ~/scripts/run-mailsync.sh &
~/scripts/autostart_wait.sh &
