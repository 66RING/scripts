#!/bin/sh


[ "$(printf "No\\nYes" | rofi -theme '~/.config/rofi/rofi-themes/slate_with_two_choice_prompt.rasi' -case-sensitive -p "$1" -dmenu  )" = "Yes" ] && $2


