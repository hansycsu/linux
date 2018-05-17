#!/bin/bash

# Store find result in array 'list' 
#
# 1. list=() create an empty array
#
# 2. 'IFS=' avoid removal of whitespace from the beginnings or ends of the input
#    lines
#
# 3. Every time that the read statement is executed, a null-separated file name
#    is read from standard input.
#
# 4. Since we omit the name to read, the shell puts the input into the default
#    name: $REPLY
#
# 5. The array+=("$REPLY") statement appends $REPLY to the array
#
# 6. Command `read` expects standard input, and
#
#        done < file.txt
#
#    redirect file content to standard input
#
#    Furthermore,
#
#        done < <(find * -maxdepth 0 -type d -print0)
#
#    redirect find output as file, then pipe as input of `read`
#
# * Command options
#
#     read -r       : do not allow backslashes to escape any characters
#     read -d $'\0' : delimiter is '\0'
#
#     find -print0  : prints the file names separated with a null character
#
# Ref: https://stackoverflow.com/questions/23356779

list=()
while IFS= read -r -d $'\0'; do
  list+=("$REPLY")
done < <(find * -maxdepth 0 -type d -print0)

echo "${list[@]}"
