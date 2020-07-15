#!/bin/sh

if [ -z "$(bspc query -N -n .focused.fullscreen -d focused)" ]; then
    #bspc node focused.tiled -t fullscreen
    bspc node focused -t fullscreen
else
    #bspc node focused.fullscreen -t tiled 
    bspc node focused -t tiled 
fi

