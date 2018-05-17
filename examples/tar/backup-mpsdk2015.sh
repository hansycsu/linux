#!/usr/bin/bash

releaseExclude='*.res
*.obj
*.dep
*.exe
*.pch
*.pdb
*.resources
*.dll
*.manifest
*.meta
*.idb'

cd /cygdrive/d/YC_Su/Workspace/MpSdk2015

tPath=/cygdrive/d/YC_Su/Workspace/MpSdk2015

folder=MpSdk2015_merged

# We pass variable as file here:
#   tar --exclude-from <(echo "$releaseExclude") ...
#   normal use: tar --exclude-from [FILE] ...
#     e.g. tar --exclude-from ~/exclude.txt -zcvf MpSdk2015_merged.tgz MpSdk2015_merged

tar --exclude-from <(echo "$releaseExclude") -zcvf "$tPath/$folder.tgz" "$folder"
