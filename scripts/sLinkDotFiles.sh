#!/bin/bash
SCR_PATH=$(dirname $BASH_SOURCE)
SCR_PATH=$(cd $SCR_PATH && pwd)
cd $SCR_PATH/../dotfiles
rm -v ~/.bash_aliases
rm -v ~/.bash_env
ln -vs $(pwd)/.bash_aliases ~/
ln -vs $(pwd)/.bash_env ~/
ln -vs $(pwd)/.gitconfig ~/
