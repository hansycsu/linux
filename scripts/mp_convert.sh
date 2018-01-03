#!/bin/bash

for file in "$@"; do
    if [ ! -f "$file" ]; then
        echo "File $file not exist!" 1>&2; continue;
    fi
    lineNumList=$(grep -n "// Comment for YC Su Test [{}]\{3\}" "$file" | awk -F: '{print $1}')
    if [ -z "$lineNumList" ]; then
        echo "Mark not found in '$file'" 1>&2; continue;
    fi
    echo "Processing $file ..."
    flag=0
    for i in $lineNumList; do
        if [ $flag == 0 ]; then
            tmpList=$i
            flag=1
        else
            tmpList=($tmpList $i)
            tmpList[0]=$(expr ${tmpList[0]} + 1)
            tmpList[1]=$(expr ${tmpList[1]} - 1)
            if [ -z "$tmpStr" ]; then
                tmpStr=$(sed "${tmpList[0]},${tmpList[1]}s/^\(\s*\)\/\//\1/" "$file")
            else
                tmpStr=$(sed "${tmpList[0]},${tmpList[1]}s/^\(\s*\)\/\//\1/" <<< "$tmpStr")
            fi
            flag=0
        fi
    done
    if [ ! -d '.send' ]; then
        mkdir '.send'
    fi
    echo "$tmpStr" > ".send/$file"
    unset tmpStr
done
