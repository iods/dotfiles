#!/bin/bash
#
# TODO: write script description
#

#
# Changing and Navigating Directory, and `ls` Aliases
#
alias .='pwd'                    # print working directory
alias ..='cd ..'                 # go up one directory
alias cd..='cd ..'               # go up one directory
alias ...='cd ../..'             # go up two directories
alias 3.='cd ../../../'          # go up three directories
alias 4.='cd ../../../../'       # go up four directories
alias 5.='cd ../../../../../'    # go up five directories
alias ~='cd $HOME'               # go to the home directory
alias -.='cd -'                  # go back to previous directory

alias path='echo $PATH | tr -s ":" "\n"'    # pretty print the $PATHs
alias fpath='echo $FPATH | tr -s ":" "\n"'  # pretty print the $FPATHs

alias tree='tree --dirsfirst'    # get description

if ls --color > /dev/null 2>&1; then
  colorflag="--color"
else
  colorflag="-G"
fi

alias ls='ls -hF ${colorflag}'   # classify files in colors
alias ll='ls -ltr'               # just a long list
alias la='ls -lA'                # list all but . and ..
alias l='ls -CF'                 # get description

alias df='df -h'                 # default to Human Readable Figures
alias du='du -h'                 # default to Human Readable Figures


#
# Git Aliases
#
alias gs='git status'            # show status of current git branch
alias gd='git diff HEAD'         # show whats changed, staged and unstaged


#
# Management
#
alias diskstat='watch -c -d -n 1 "sudo S_COLORS=always iostat -xmdzc -t 1 1"'
alias diskuse='watch -c -d -n 1 "sudo S_COLORS=always sar -d 0"'
alias httpdump='sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\"'
alias iotop='sudo iotop -oa'
alias mpstat='watch -c -d -n 1 "sudo S_COLORS=always mpstat -P ALL"'
alias netuse='watch -c -d -n 1 "sudo S_COLORS=always sar -n DEV 0"'
alias sniff='lsof -i 4tcp'
alias tf='tail -F -n200'
alias top='top -ocpu'
alias vmstat='vmstat -Sm 1'

alias grep='grep --color=auto '
alias p='ps aux | grep -v ]$'
alias pg='ps aux | head n1; ps aux | grep -i'
alias sudo='sudo '  # http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo

alias sc-dreload='sudo systemctl daemon-reload'


#
# Misc Aliases
#
alias cp='cp -i'
alias dots='cd "${HOME}"/.dotfiles'
alias get="wget --no-clobber --page-requisites --html-extension --convert-links --no-host-directories"
alias hosts='sudo vim /etc/hosts'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias pull="curl -O -L"
alias q='logout'
alias :q='logout'
alias reload='source "${HOME}"/.bash_profile && echo "sourced ~/.bash_profile"'
alias rm='rm -i'
alias updot='printf "Updating dotfiles."'


#
# OSX Aliases
#
alias binge='brew update && brew upgrade && brew upgrade --cask && brew cleanup'
alias cleanup='find . -type f -name "*.DS_Store" -ls -delete'
alias clipdecode='pbpaste|base64 --decode'
alias oping='sudo oping'
alias noping='sudo noping'
alias takeouttrash='sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv $HOME/.Trash; sudo rm -rfv /private/var/log/asl/*.asl'


#
# Ubuntu OS Aliases
#
alias open='xdg-open'