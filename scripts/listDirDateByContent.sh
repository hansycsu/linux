#!/bin/bash
# Ref: https://stackoverflow.com/questions/23356779

list=()
while IFS=  read -r -d $'\0'; do
  list+=("$REPLY")
done < <(find * -maxdepth 0 -type d -print0)

for file in "${list[@]}"; do
  time=$(find "$file" -type f -exec stat \{} --printf="%y\n" \; | sort -n -r | head -n 1)
  if [ -z "$time" ]; then
    time=$(stat $file -c "%y")
  fi

  echo $time $file
done
