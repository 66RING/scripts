#!/bin/bash

coord=$(hyprctl cursorpos)

y=$(echo $coord | cut -d',' -f2)

if (( y <= 0 )); then
  exec -a __toggle_bar_autohide bash $SCRIPTS_DIR/hyprland/toggle_bar_autohide &
fi

