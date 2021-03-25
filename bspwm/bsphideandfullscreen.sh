#!/bin/sh

if [ -z "$(bspc query -N -n .focused.fullscreen -d focused)" ]; then
  bspc node focused -t fullscreen
  NODES=$(bspc query -N -n .tiled -d focused)
  for node in $NODES; do
    bspc node $node -g hidden=on
  done
else
  bspc node focused -t \~fullscreen
  NODES=$(bspc query -N -n .tiled.hidden -d focused)
  for node in $NODES; do
    bspc node $node -g hidden=off
  done
fi
