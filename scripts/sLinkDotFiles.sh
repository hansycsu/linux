#!/bin/bash
SCR_PATH=$(dirname $BASH_SOURCE)
SCR_PATH=$(cd $SCR_PATH && pwd)
cd $SCR_PATH/../dotfiles
ln -vs .bash_aliases
ln -vs .bash_env    
