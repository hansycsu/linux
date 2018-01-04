#!/bin/bash

function gitCheck {
    echo '======================================================'
    echo in "$1" :
    cd "$1"
    if [ "$(git remote -v 2>/dev/null)" ]; then
        echo "Remote repo has set, run 'git fetch' ..."
        git fetch
    fi
    git status
}

gitCheck ~/linux
gitCheck ~/.vim
