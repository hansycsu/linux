#!/bin/bash
#############################################################################
# Input:
#   $tPath (Target path to store tgz file)
#   $folder (Folder name to backup)
#   $fileName (Optional, it would be $folder.tgz by default)
#   $tarArgs (Optional, this can be used to pass arguments of tar command)
#
# Note: Change working directory first
# ---------------------------------------------------------------------------
# Example:
#   cd "/home/user/Qt_Workspace"
#   tPath="/backup"
#   
#   folder="Project1"
#   tarArgs=("--exclude=*.ini" "--exclude=*.bak")
#   backupFolder
#   
#   folder="Project2"
#   fileName="my_name.tar.gz"
#   backupFolder
#############################################################################

backupFolder() {
  # if folder not exist
  if [ ! -d "$folder" ]; then
    echo "Folder '$folder' not exist!" 1>&2
    return 1
  fi

  # if fileName is not defined
  if [ -z "$fileName" ]; then
    fileName="$folder.tgz"
  fi

  # if tgz file exists
  if [ -e "$tPath/$fileName" ]; then

    # if date (folder > tgz file) (newer than)
    if [ $(stat -c %Y "$folder") -gt $(stat -c %Y "$tPath/$fileName") ]; then
    echo "$folder -> $tPath/$fileName [${tarArgs[@]}]"
    tar -zcf "$tPath/$fileName" "${tarArgs[@]}" "$folder"
    else
      echo "$fileName is up to date."
    fi

  # if tgz file does not exist
  else
    echo "$folder -> $tPath/$fileName [${tarArgs[@]}]"
    tar -zcf "$tPath/$fileName" "${tarArgs[@]}" "$folder"
  fi
  unset fileName
}

