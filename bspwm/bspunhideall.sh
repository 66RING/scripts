#!/bin/sh

NODES=$(bspc query -N -n .tiled.hidden -d focused)
for node in $NODES; do
  bspc node $node -g hidden=off
done
