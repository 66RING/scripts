#!/bin/sh
NODES=$(bspc query -N -n .tiled.hidden -d focused)
#polybar-msg cmd show
for node in $NODES; do
  bspc node $node -g hidden=off
done
