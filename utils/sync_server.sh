#!/bin/bash

# TODO: implement it in rust!!! as "async mount"

# require rsync, fswatch
local_repo_path=./
remote_node_=$1
remote_path=$2
exclude_file=$local_repo_path".gitignore"
exclude_pattern=(".git" ".gitignore")
max_file_size=10m

sync_cmd="rsync -avhz --delete --force --max-size=$max_file_size $local_repo_path"

if [ ! -z "$exclude_file" ] && [ -f $local_repo_path/$exclude_file ]; then
    sync_cmd="$sync_cmd --exclude-from=$exclude_file"
fi

for pattern in ${exclude_pattern[@]}; do
    sync_cmd="$sync_cmd --exclude=$pattern"
done

sync_cmd="$sync_cmd $remote_node_:$remote_path"
echo $sync_cmd
eval $sync_cmd

while true; do
  echo "fswatching" $local_repo_path"**/*"
  fswatch -1 "$local_repo_path"/* "$local_repo_path"**/* > /dev/null
  eval $sync_cmd
  sleep 1
done

