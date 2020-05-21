#!/usr/bin/bash
pids=$(xdotool search --class scratchpad)

if [ "$pids" == "" ]; then
  #eval "st -c scratchpad &"
  eval "st -c scratchpad -t scratchpad -g 80x30"
else
  for pid in $pids; do
  	bspc node $pid --flag hidden -f
  done
fi

