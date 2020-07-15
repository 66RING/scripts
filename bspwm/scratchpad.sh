#!/usr/bin/bash
pids=$(xdotool search --class scratchpad)

if [ "$pids" == "" ]; then
    # eval "st -c scratchpad -t scratchpad -g 80x30"
    eval "alacritty --class scratchpad,scratchpad -d 80 30"
else
  for pid in $pids; do
  	bspc node $pid --flag hidden -f
  done
fi

