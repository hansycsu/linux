#!/bin/bash

# Code grep : cgrep
#
# Only search in cpp and h file, reserve colors, and format output (replace
# leading space with a tab)
#
# You can:
#   - add '-o -name ...' to include any other filenames
#   - remove '-maxdepth 0' if you want to search recursively
#   - modify '! -name ...' to exclude any filenames

cgrep() {
  if [ -z "$1" ] || [ -n "$2" ]; then
    echo "Error: Unknown argument"
    echo "Syntax: cgrep [pattern]"
    exit 0
  fi

  find * -maxdepth 0 -type f \( -name '*.h' -o -name '*.cpp' \) ! -name 'v_*' -exec \
    grep --color=always -aHn "$1" {} + |
    sed -Ee 's/^([^:]+:[^:]+:.{6})\s*/\1\t/'
}
