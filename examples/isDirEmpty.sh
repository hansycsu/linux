#!/bin/bash
DIR_TO_CHECK=$1
if [ -n "$(find "$DIR_TO_CHECK" -maxdepth 0 -type d -empty 2>/dev/null)" ]; then
    echo Empty!
else
    echo Not Empty!
fi
