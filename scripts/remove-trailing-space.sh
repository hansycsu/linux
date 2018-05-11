#!/bin/bash

if [ "$#" -lt 1 ]; then
  echo  "No input file specified."
  exit
fi

for file in "$@"; do
  if [ -f "$file" ]; then
    if grep -q '[[:space:]]\+$' "$file"; then
      echo "[!] $file trailing space found."
      tArray+=("$file")
    else
      echo "[ ] $file ... OK."
    fi
  fi
done

if [ "${#tArray[@]}" -lt 1 ]; then
  echo -e "\nGreat! All files are without trailing space."
else
  echo # print \n
  read -p "Do you want to remove trailing space in [!] files? [y/N]: " -n 1 -r

  # User input: Yes
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n"
    for i in "${tArray[@]}"; do
      echo "Processing $i ..."
      sed --in-place 's/[[:space:]]\+$//' "$i"
    done
  fi
fi
