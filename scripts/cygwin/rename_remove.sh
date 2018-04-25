#!/bin/bash
DIR_MAN1=/usr/local/share/man/man1

rm -v /usr/local/bin/rename
rm -v /usr/local/share/man/man1/rename.1.gz

if [ -n "$(find "$DIR_MAN1" -maxdepth 0 -type d -empty 2>/dev/null)" ]; then
    echo man1 is empty!
    rm -rv "$DIR_MAN1"
else
    echo man1 is not empty!
fi
