#!/bin/bash
# --------------------------------------------------
# Copy Me
# --------------------------------------------------
SCR_PATH=$(cd "$(dirname "${BASH_SOURCE}")" && pwd)
# --------------------------------------------------

# --------------------------------------------------
# Step by step analysis
# --------------------------------------------------
echo \$BASH_SOURCE:[$BASH_SOURCE]

SCR_PATH=$(dirname "$BASH_SOURCE")
echo after dirname:[$SCR_PATH]

SCR_PATH=$(cd "$SCR_PATH" && pwd)
echo after cd and pwd:[$SCR_PATH]
