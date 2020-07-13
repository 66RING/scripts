#!/bin/sh

if [ -z "$(bspc query -N -n .focused.fullscreen -d focused)" ]; then
    bspc node focused.tiled -t fullscreen
    /home/ring/scripts/bspwm/bsphide.sh
else
    bspc node focused.fullscreen -t tiled
    /home/ring/scripts/bspwm/bspunhide.sh
fi
