#!/bin/bash
if [ "$1" == "mint" ]; then
    echo "Processing mint..."
elif [ "$1" == "cygwin" ]; then
    echo "Processing cygwin..."
else
    echo "Error: Unknown argument"
    echo "Syntax: init [mint|cygwin]"
    exit 0
fi

./init/sLinkDotFiles.sh "$1"
if [ "$1" == "mint" ]; then
    echo "Skip perl rename in mint"
elif [ "$1" == "cygwin" ]; then
    echo "Install perl rename in cygwin"
    ./init/rename_install.sh
fi
./init/vimfiles_init.sh
