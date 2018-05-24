#!/bin/bash
# gdrive.sh - download google drive file by id"
# (c) 2018 YC Su <hansycsu@gmail.com>

usage() {
  echo "NAME"
  echo "    gdrive.sh - download google drive file by id"
  echo ""
  echo "SYNOPSIS"
  echo "    gdrive.sh [-l] <FILE ID> <FILENAME>"
  echo ""
  echo "DESCRIPTION"
  echo "    <FILE ID>"
  echo "        ID of google drive file"
  echo "    <FILENAME>"
  echo "        Download path and file name. e.g. '/tmp/download.tgz'"
  echo "    -l"
  echo "        Use large file confirm"
}

downloadNormal() {
  id=$1
  filename=$2
  echo 'Normal file mode'
  echo "id: [$id]"
  echo "filename: [$filename]"
  wget --no-check-certificate "https://docs.google.com/uc?export=download&id=$id" -O "$filename"
}

downloadLarge() {
  id=$1
  filename=$2
  echo 'Large file mode'
  echo "id: [$id]"
  echo "filename: [$filename]"
  confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=$id" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')
  wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$confirm&id=$id" -O "$filename" && rm -f /tmp/cookies.txt
}

case $# in
  2)
    downloadNormal "$1" "$2"
    ;;
  3)
    if [ "$1" == '-l' ]; then
      downloadLarge "$2" "$3"
    else
      usage
      exit
    fi
    ;;
  *)
    usage
    exit
    ;;
esac
