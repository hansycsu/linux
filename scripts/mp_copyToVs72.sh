#!/bin/bash

cd .send
fileList=$(ls | grep -v '^clear$')
vPath='/cygdrive/d/imx6/vs72/vs72/scr_pg'

OLD_IFS=$IFS
IFS=$'\n'
for file in $fileList; do
    sum0=$(stat -c %s "$file")
    if [ -f "$vPath/$file" ]; then
        sum1=$(stat -c %s "$vPath/$file")
    else
        sum1=NULL
    fi

    if [ $sum0 == $sum1 ]; then
        echo "$file equals!"
    else
        cp -auv "$file" "$vPath/"
        #echo copy "$file" to "$vPath/"
    fi
done
IFS=$OLD_IFS
