#!/bin/sh
if [ -z "$(bspc query -N -n .focused.fullscreen -d focused)" ]; then
    bspc node focused.tiled -t fullscreen
else
    bspc node focused.fullscreen -t tiled
fi

