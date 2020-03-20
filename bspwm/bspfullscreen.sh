#!/bin/sh

HideBar(){
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
    # if true &&
    bspc node focused.tiled -t fullscreen &&
    HideBar
else
    bspc node focused.fullscreen -t tiled &&
    ShowBar
fi

