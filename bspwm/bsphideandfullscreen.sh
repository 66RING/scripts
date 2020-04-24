#!/bin/sh
HideBar(){
    bspc config bottom_padding 2
    if pgrep "polybar"; then
        polybar-msg cmd hide
    fi
}

ShowBar(){
    if pgrep "polybar"; then
        polybar-msg cmd show
    fi
}

if [ -z "$(bspc query -N -n .focused.fullscreen -d focused)" ]; then
    HideBar
    bspc node focused.tiled -t fullscreen
    /home/ring/scripts/bspwm/bsphide.sh
else
    ShowBar
    bspc node focused.fullscreen -t tiled
    /home/ring/scripts/bspwm/bspunhide.sh
fi
