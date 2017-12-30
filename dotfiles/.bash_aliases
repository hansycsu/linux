# Editted by YC Su 2017.12.28

alias ls='ls -F --color=auto --group-directories-first'
alias ll='ls -l'
alias lla='ls -lA'
alias la='ls -A'
# A backslash before command to avoid recursion and define
alias l='\ls'
alias dirs='dirs -v'
alias so='source'
# -ixon for Ctrl-S -ixoff for Ctrl-Q
stty -ixon -ixoff
