#!/bin/sh

if [ -z "$(bspc query -N -n .focused.fullscreen -d focused)" ]; then
    bspc node focused -t fullscreen
    /home/ring/scripts/bspwm/bsphideall.sh
else
    bspc node focused -t \~fullscreen
    /home/ring/scripts/bspwm/bspunhideall.sh
fi
