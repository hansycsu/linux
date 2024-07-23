# Created by YC Su

alias ls='ls -F --color=auto --group-directories-first --time-style=long-iso'
alias ll='ls -l'
alias lla='ls -lA'
alias la='ls -A'
# A backslash before command to avoid recursion and define
alias l='\ls'
alias dirs='dirs -v'
alias so='source'
alias grep='grep --color=auto'
alias yclsblk='lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,UUID'
alias sudo='sudo '
alias ycps='ps axo pid,user,ppid,%cpu,%mem,comm'
alias ycpsd='ps axo pid,user,ppid,%cpu,%mem,args'
alias df='df -T'
alias topp='top -b -n 1'
alias vir='vim -R'
alias hoff='set +o history'
alias hon='set -o history'
alias cpt='cp --preserve=timestamps'
psfilter() {
  grep "$@" | grep -v grep
}
alias ycpsf='ycpsd | psfilter '
c() {
  cd "$@"; ll
}
cfilelistgen() {
  if [ ! -d .ycsu ]; then
    mkdir .ycsu
  fi
  cd .ycsu
  find ../* -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" > filelist-cpp
  cd ..
}
cstaggen() {
  if [ ! -d .ycsu ]; then
    echo No .ycsu directory
    return 0
  fi
  cd .ycsu
  if [ ! -f filelist-cpp ]; then
    echo No filelist-cpp
    return 0
  fi
  ctags -L filelist-cpp ; cscope -bqki filelist-cpp
  cd ..
}
