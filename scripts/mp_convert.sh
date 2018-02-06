#!/bin/bash

fileList=( 'cls_s_p_textedit_ts6edit.cpp'
           'cls_s_p_textedit_ts6edit.h'
           'ts/cc_ts1.cpp' 'ts/cc_ts1.h' )

for file in "${fileList[@]}"; do
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
  fileName=$(basename "$file")
  echo "$tmpStr" > ".send/$fileName"
  unset tmpStr
done


# Check size & Copy .send/ files to vs72
updateVs72 () {
  for file in "${fileList[@]}"; do
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
    fi
  done
}

cd .send
fileList=( 'cls_s_p_textedit_ts6edit.cpp' 'cls_s_p_textedit_ts6edit.h' )
vPath='/cygdrive/d/imx6/vs72/vs72/scr_pg'
updateVs72

fileList=( 'cc_ts1.cpp' 'cc_ts1.h' )
vPath='/cygdrive/d/imx6/vs72/vs72/ts'
updateVs72
