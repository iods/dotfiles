#!/bin/bash
#
# TODO: write script description
#

#
# [1 Default Aliases
#
alias .='pwd'                               # print working directory
alias ..='cd ..'                            # go up one directory
alias cd..='cd ..'                          # go up one directory
alias ...='cd ../..'                        # go up two directories
alias 3.='cd ../../../'                     # go up three directories
alias 4.='cd ../../../../'                  # go up four directories
alias 5.='cd ../../../../../'               # go up five directories
alias ~='cd $HOME'                          # go to the home directory
alias -.='cd -'                             # go back to previous directory
alias path='echo $PATH | tr -s ":" "\n"'    # pretty print the $PATHs
alias fpath='echo $FPATH | tr -s ":" "\n"'  # pretty print the $FPATHs
alias tree='tree --dirsfirst'               # get tree aliases
if ls --color > /dev/null 2>&1; then        # detect which `ls` flavor is in use
  colorflag="--color"
else
  colorflag="-G"
fi
alias lsd='ls -l | grep "^d"'               # list only directories
alias ls="ls -hF ${colorflag}"              # classify files in colors
alias ll='ls -ltr'                          # just a long list
alias la='ls -lA'                           # list all but . and ..
alias lca="ls -la ${colorflag}"             # list all files colorized in long format, dots too
alias lc="ls -l ${colorflag}"               # list all files colorized in long format
alias l='ls -CF'                            # get description
alias df='df -h'                            # default to Human Readable Figures
alias du='du -h'                            # default to Human Readable Figures


#
# [2 Application Aliases
#
# alias slt='open -a "Sublime Text 2"'
# alias pstorm='open -a "Sublime Text 2"'
alias chrome='open /Applications/Google\ Chrome.app'
alias plistbuddy='/usr/libexec/PlistBuddy'             # listBuddy alias, because sometimes `defaults` just doesn’t cut it
alias subl='"/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"'
# alias subl="source '/Applications/Sublime Text 2.app/Contents/MacOS/Sublime Text 2'"
# alias subpacks="cd '/Library/Application Support/Sublime Text 2/Packages'"


#
# [3 Management and Monitoring Aliases
#
alias diskstat='watch -c -d -n 1 "sudo S_COLORS=always iostat -xmdzc -t 1 1"'
alias diskuse='watch -c -d -n 1 "sudo S_COLORS=always sar -d 0"'
alias fs='stat -f \"%z bytes\"'
alias flush="dscacheutil -flushcache"
alias grep='grep --color=auto '
alias httpdump='sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\"'
alias iotop='sudo iotop -oa'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias localip="ipconfig getifaddr en1"
alias mpstat='watch -c -d -n 1 "sudo S_COLORS=always mpstat -P ALL"'
alias netuse='watch -c -d -n 1 "sudo S_COLORS=always sar -n DEV 0"'
alias p='ps aux | grep -v ]$'
alias pg='ps aux | head n1; ps aux | grep -i'
alias sc-dreload='sudo systemctl daemon-reload'
alias sniff='lsof -i 4tcp'
alias sniffd="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias sudo='sudo '                          # http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias tf='tail -F -n200'
alias top='top -ocpu'
alias vmstat='vmstat -Sm 1'
alias whois="whois -h whois-servers.net"    # enhanced WHOIS lookups


#
# [4 Git Aliases
#
alias gd='git diff HEAD'                    # show whats changed, staged and unstaged
alias gs='git status'                       # show status of current git branch
alias gtree='git log --graph --full-history --all --color --pretty=format:"%x1b[33m%h%x09%x09%x1b[32m%d%x1b[0m %x1b[34m%an%x1b[0m   %s" "$@"'


#
# [5 Tools and Miscellaneous Aliases
#
alias dots='cd "${HOME}"/.dotfiles'
alias emptytrash='sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash'
alias get="wget --no-clobber --page-requisites --html-extension --convert-links --no-host-directories"
alias hosts='sudo vim /etc/hosts'
alias line="sed -n '\''\!:1 p'\'' \!:2" # show line 5 of file
alias pull="curl -O -L"
alias reload='source "${HOME}"/.bash_profile && echo "sourced ~/.bash_profile"'
alias stfu='osascript -e "set volume output muted true"'
alias tits='growlnotify -a "Activity Monitor" "System error" -m "Testing this."'
alias trimcopy="tr -d '\n' | pbcopy"
alias updot='printf "Updating dotfiles."'


#
# [6 Linux OS and Mac OSX Aliases
#
alias binge='brew update && brew upgrade && brew upgrade --cask && brew cleanup'
alias cleanup='find . -type f -name "*.DS_Store" -ls -delete'
alias clipdecode='pbpaste|base64 --decode'
alias crankit='osascript -e "set volume 10"'
alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias open='xdg-open'
alias oping='sudo oping'
alias noping='sudo noping'
alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'
alias takeouttrash='sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv $HOME/.Trash; sudo rm -rfv /private/var/log/asl/*.asl'
# alias todo='todo.sh'
alias wordcount='(cat \!* | tr -s '\''  .,;:?\!()[]"'\'' '\''\012'\'' | cat -n | tail -1 | awk '\''print $1'\'')'

# type -t md5sum > /dev/null || alias md5sum="md5"     # OS X has no `md5sum`, so use `md5` as a fallback


#
# [7 Shortcuts
#
alias c='clear'
alias cp='cp -i'
alias dx='du -k | more'
alias ff='find . -name \!:1 -print'
alias g='git'
alias mv='mv -i'
alias px='ps uxa | more'
alias q='exit'
alias :q='logout'
alias rm='rm -i'
alias v='vim'
