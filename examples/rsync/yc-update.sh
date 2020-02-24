#!/bin/bash

msync () {
  rsync "$@" | grep -E --color=never '^deleting|[^/]$'
}

printHelp () {
  echo 'yc-update.sh [--run | --help]'
}

# c: compare files by checksum
# r: recursive
# t: preserve modification time
# v: verbose
# delete: delete extraneous files from the receiving side
RSYNC_OPTION='-crtv --delete --exclude-from=.gitignore'

# The '/' at the end of SOURCE_DIR is very important
# rsync /a/ /b/:  /a  ==>  /b
# rsync /a /b/ :  /a  ==>  /b/a
SOURCE_DIR='/a/vs72/'
TARGET_DIR='/cygdrive/d/imx6/vs72/vs72/'

if [ "$1" == '--help' ]; then
  printHelp
  exit 0
elif [ "$1" == '--run' ]; then
  msync $RSYNC_OPTION "$SOURCE_DIR" "$TARGET_DIR"
else
  msync $RSYNC_OPTION --dry-run "$SOURCE_DIR" "$TARGET_DIR"
fi
