#!/bin/bash

# Check size & Copy .send/ files to $tPath
# Input: (array) $fileList , (string) $tPath
# Output: (file) $tPath/*
updateFiles () {
  for file in "${fileList[@]}"; do
    sum0=$(stat -c %s "$file")
    if [ -f "$tPath/$file" ]; then
      sum1=$(stat -c %s "$tPath/$file")
    else
      sum1=NULL
    fi

    if [ $sum0 == $sum1 ]; then
      echo "'$file' equals!"
    else
      cp -auv "$file" "$tPath/"
    fi
  done
}

