#!/bin/bash
git clone https://github.com/hansycsu/.vim.git ~/.vim/
cd ~/.vim/
git submodule init
git submodule update
cd bundle/Vundle.vim
git checkout master
vim +PluginInstall +qall
