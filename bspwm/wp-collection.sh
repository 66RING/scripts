#!/bin/bash

chosen=$(ls -F /home/ring/Pictures/wallpapers | grep '/$' | tr -d '/' | rofi -dmenu -i)

[ "$chosen" != "" ] || exit

line="feh --recursive --randomize --bg-fill --no-fehbg ~/Pictures/wallpapers/$chosen"
script_dir="/home/ring/scripts/wp-change.sh"
num=$(sed -n '/^feh/=' $script_dir)

sed -i "${num}c ${line}" $script_dir

bash $script_dir
