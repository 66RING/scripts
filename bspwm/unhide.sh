#!/usr/bin/env sh

NODES=($(bspc query -N -n .local.window.\!sticky.hidden))
INDEX=0
list=""

if [ -z "$NODES" ]; then
    notify-send "👻 Nothing is hidden." "Catch you later XD"
    exit
fi

for node in ${NODES[@]}; do
    list="$list$INDEX $(xdotool getwindowname $node)\n"
    ((INDEX++))
done

chosen=$(echo -e $list | rofi -theme "~/.config/rofi/rofi-themes/slate_without_prompt.rasi" -dmenu -i | awk '{ print $1 }')

[ -n "$chosen" ] || exit

bspc node ${NODES[$chosen]} -g hidden=off

