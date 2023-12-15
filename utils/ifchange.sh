#!/bin/bash

# Execute command if any change in current path

# ifchange "./* ./**/*" cmd

files=$1

shift
cmd=$@

echo "watching on$files"
echo "$cmd"
eval $cmd

while true; do
  fswatch -1 $files > /dev/null
  eval $cmd
  sleep 1
done

