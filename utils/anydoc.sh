#!/bin/sh

# 1. convert to html first for compatibility
# 2. convert to $1 actually
if [ $# -gt 0 ] ;then
  tmp="$(mktemp --suffix='.html')"
  pandoc "$2" -N -t html -o "$tmp"
  pandoc "$tmp" -t $1 -o $(echo "$2" | cut -d '.' -f 1)".$1"
  rm "$tmp"
else
  echo -e "Usage:\n\tosdoc <output_type> <input_file>"
fi
