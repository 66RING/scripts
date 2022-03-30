#!/bin/sh

util=$(echo -e "loopback" | rofi -p "which utils ?" -dmenu -i)

if [ "$util" = "loopback" ]; then
  func=$(echo -e "on\noff" | rofi -p "which function ?" -dmenu -i)
  if [ "$func" = "on" ]; then
	pactl load-module module-loopback
  elif [ "$func" = "off" ]; then
	pactl unload-module module-loopback
  fi
# elif 
fi

