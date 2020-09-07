#!/usr/bin/env sh

NODES=($(bspc query -N -n .local.window.\!sticky.hidden))
INDEX=0
choose=""

for node in ${NODES[@]}; do
    choose="$choose$INDEX $(xdotool getwindowname $node)\n"
    ((INDEX++))
done

chosen=$(echo -e $choose | rofi -theme "~/.config/rofi/rofi-themes/slate_without_prompt.rasi" -dmenu -i | awk '{ print $1 }')

[ "$chosen" != "" ] || exit

bspc node ${NODES[$chosen]} -g hidden=off

