#!/bin/bash
doCopy() {
  cp -a "$file" "$tPath/" && echo "'$file' -> '$tPath/$file'"
}
# Check size & Copy files to $tPath
# Input: (array) $fileList , (string) $tPath
# Output: (file) $tPath/*
updateFiles() {
  for file in "${fileList[@]}"; do
    if [ -f "$file" ]; then
      sum0=$(stat -c %s "$file")
    else
      echo "File '$file' not exist!" 1>&2
      continue
    fi

    if [ -f "$tPath/$file" ]; then
      sum1=$(stat -c %s "$tPath/$file")
    else
      doCopy
      continue
    fi

    if [ $sum0 -eq $sum1 ]; then
      echo "'$file' equals!"
    else
      doCopy
    fi
  done
}

