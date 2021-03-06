#!/usr/bin/env sh

# The famous "get a menu of emojis to copy" script.

# Must have xsel installed to even show menu.
#xsel -h >/dev/null || exit


#chosen=$(cut -d ';' -f1 ~/scripts/static/emoji | dmenu -i -l 20 -fn monospace-25)
chosen=$(cut -d ';' -f1 ~/scripts/static/emoji | rofi -theme "~/.config/rofi/rofi-themes/slate_without_prompt.rasi" -dmenu -i -p "$1")



[ "$chosen" != "" ] || exit

c=$(echo "$chosen" | sed "s/ .*//")
echo "$c" | tr -d '\n' | xsel -b
notify-send "'$c' copied to clipboard." &

#s=$(echo "$chosen" | sed "s/.*; //" | awk '{print $1}')
#echo "$s" | tr -d '\n' | xclip
#notify-send "'$s' copied to primary." &
