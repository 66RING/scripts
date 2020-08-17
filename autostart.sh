#!/bin/bash

#xrandr --auto --output HDMI1 --same-as eDP1 --size 1920x1080
xrandr --output eDP --scale 0.8x0.8 &
#/bin/bash ~/scripts/dwm-status.sh &
/bin/bash ~/scripts/wp-autochange.sh &
picom -b --experimental-backends &

/bin/bash ~/scripts/tap-to-click.sh &
/bin/bash ~/scripts/inverse-scroll.sh &
xss-lock slock &
nm-applet &
#/bin/bash ~/scripts/run-mailsync.sh &
~/scripts/autostart_wait.sh &
