#!/bin/sh

if [ $# -gt 0 ] ;then
  tmp="$(mktemp --suffix='.html')"
  pandoc "$1" -N -t html -o "$tmp"
  pandoc "$tmp" -t odt -o $(echo "$1" | cut -d '.' -f 1)'.odt'
  rm "$tmp"
else
  echo -e "Usage:\n\tosdoc <input_file>"
fi
