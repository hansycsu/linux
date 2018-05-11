#!/usr/bin/bash

# List untracked files of git status and sort by file extension
# 1. grep '^\s\+\w'  | show only files
# 2. grep -v ':'     | show only untraced files
# 3. sed 's/^\s\+//' | remove leading space
# 4. awk:
#      -F'.' : set delimiter is '.'
#      NF    : number of fields
#      $NF   : final field
git status | grep '^\s\+\w' | grep -v ':' | sed 's/^\s\+//' | \
  awk -F'.' '{
    if (NF == 1)
      printf("%20s %s\n", " ", $0);
    else
      printf("%-20s %s\n", $NF, $0);
  }' | sort -k 1
