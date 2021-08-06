#!/bin/sh
#

# get info from xrandr
allconnects=$(xrandr -q | grep "connected")


screens=$(echo "$allconnects" | awk '/ connected/ {print $1}')

toDefault() { # If multi-monitor is selected and there are more than two screens.
    xrandr --output "$(echo $screens | head -1)" --auto
    discnt=$(echo "$allconnects" | awk '/ disconnected/ {print $1}')
    for dis in $discnt; do
        xrandr --output "$dis" --off
    done
    [ -f "$HOME/.config/polybar/launch.sh" ] && eval "$HOME/.config/polybar/launch.sh &"

    notify-send "💻 Only one screen detected." "Using it in its optimal settings..."
    exit
}


if [ "$(echo "$screens" | wc -l)" -lt 2 ]; then
    toDefault
fi

external=$(echo -e "$screens\nDefault" | rofi -dmenu -i -p "Optimize resolution for:")

if [ "$external" == "" ]; then
    exit
elif [[ $external == "Default" ]]; then
    toDefault
fi

internal=$(echo "$screens" | grep -v "$external")

res_external=$(xrandr --query | sed -n "/^$external/,/\+/p" | \
    tail -n 1 | awk '{print $1}')
res_internal=$(xrandr --query | sed -n "/^$internal/,/\+/p" | \
    tail -n 1 | awk '{print $1}')

res_ext_x=$(echo "$res_external" | sed 's/x.*//')
res_ext_y=$(echo "$res_external" | sed 's/.*x//')
res_int_x=$(echo "$res_internal" | sed 's/x.*//')
res_int_y=$(echo "$res_internal" | sed 's/.*x//')

scale_x=$(echo "$res_ext_x / $res_int_x" | bc -l)
scale_y=$(echo "$res_ext_y / $res_int_y" | bc -l)

xrandr --output "$external" --auto --scale 1.0x1.0 \
    --output "$internal" --auto --same-as "$external" \
    --scale "$scale_x"x"$scale_y"

[ -f "$HOME/.config/polybar/launch.sh" ] && eval "$HOME/.config/polybar/launch.sh &"


