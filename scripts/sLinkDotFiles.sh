#!/bin/bash
SCR_PATH=$(dirname $BASH_SOURCE)
SCR_PATH=$(cd $SCR_PATH && pwd)
cd $SCR_PATH/../dotfiles
ln -vs $(pwd)/.bash_aliases ~/
ln -vs $(pwd)/.bash_env ~/
