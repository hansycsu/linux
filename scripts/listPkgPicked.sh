#!/bin/bash
list1=$(apt-mark showmanual | sort -u)
list2=$(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)
comm -23 <(echo "$list1") <(echo "$list2")
