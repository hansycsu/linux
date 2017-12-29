#!/bin/bash
SCR_Path=$(dirname $BASH_SOURCE)
SCR_Path=$(cd $SCR_Path && pwd)
# now SCR_Path is absolute path where script is
cd $SCR_Path/cls_s_p_textedit_ts6edit/
cp -auv cls_s_p_textedit_ts6edit.cpp cls_s_p_textedit_ts6edit.h /cygdrive/d/imx6/vs72/vs72/scr_pg/
