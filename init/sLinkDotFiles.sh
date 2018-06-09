#!/bin/bash

if [ "$1" == "mint" ]; then
    echo "Processing mint..."
elif [ "$1" == "cygwin" ]; then
    echo "Processing cygwin..."
else
    echo "Error: Unknown argument"
    echo "Syntax: sLinkDotFiles <mint|cygwin>"
    exit 0
fi

SCR_PATH=$(dirname $BASH_SOURCE)
SCR_PATH=$(cd $SCR_PATH && pwd)
cd $SCR_PATH/../dotfiles

echo "Linking general files..."
ln -fsv $(pwd)/.bash_aliases ~/
ln -fsv $(pwd)/.bash_env ~/
ln -fsv $(pwd)/.gitconfig ~/

if [ "$1" == "mint" ]; then
    echo "Linking mint files..."
    ln -fsv $(pwd)/.bashrc_mint ~/.bashrc
    ln -fsv $(pwd)/.inputrc_mint ~/.inputrc
elif [ "$1" == "cygwin" ]; then
    echo "Linking cygwin files..."
    ln -fsv $(pwd)/.bashrc_cygwin ~/.bashrc
    ln -fsv $(pwd)/.inputrc_cygwin ~/.inputrc
fi
