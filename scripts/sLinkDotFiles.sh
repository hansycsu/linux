#!/bin/bash
SCR_PATH=$(dirname $BASH_SOURCE)
SCR_PATH=$(cd $SCR_PATH && pwd)
cd $SCR_PATH/../dotfiles
for i in $(ls -A); do
    ln -vs $(pwd)/$i ~/
done
