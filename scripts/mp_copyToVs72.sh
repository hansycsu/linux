#!/bin/bash

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
