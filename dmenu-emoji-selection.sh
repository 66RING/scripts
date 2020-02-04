#!/bin/sh

grep -v "#" ~/scripts/static/emoji_unicode | dmenu -i -l 20 -fn Monospace-18 | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard

pgrep -x dunst >> /dev/null && notify-send "$(xclip -o -selection clipboard) copied to clipboard."


