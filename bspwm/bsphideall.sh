#!/bin/sh

NODES=$(bspc query -N -n .tiled -d focused)
for node in $NODES; do
  bspc node $node -g hidden=on
done

