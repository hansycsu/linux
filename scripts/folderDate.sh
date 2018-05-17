#!/bin/bash

folderDate() {
  time=$(find "$1" -type f -exec stat {} --printf="%y\n" \; | sort -n -r | head -n 1)
  if [ -z "$time" ]; then
    time=$(stat "$1" -c "%y")
  fi
  echo "$time"
}
