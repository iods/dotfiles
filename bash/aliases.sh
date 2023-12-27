#!/bin/bash




# go back to previous directory
alias -.='cd -'

# local bins
alias airplane='~/.local/bin/toggle-airplane'


# various ways of copying files, like interactively too
alias cpy="tr -d '\\n' | xclip -selection clipboard"
alias cp='cp -i'

# copy the current working directory
alias cwd='pwd | tr -d "\r\n" | xclip -selection clipboard'

# default to Human Readable Figures
alias df='df -h'
alias du='du -h'
alias dx='du -k | more'

# TODO: get description
alias ff='find . -name \!:1 -print'

# source zsh
alias ez='exec zsh'
alias sz='exec zsh'

# always enable colored `grep` output
alias grep='grep --color=auto '

# review the history
alias hist='history|tail'

# Intuitive map function
# list all directories that contain a certain file: find . -name .gitattributes | map dirname
alias map="xargs -n1"

# make directory, then cd into it
alias mkcd='makecd(){mkdir -p "$1"; cd "$1"}; makecd'

# move a file interactively
alias mv='mv -i'

# python language updates
alias p='${PYTHON}'
alias pmp='${PYTHON} -m pip'

# print paths line by line
alias paths='print -rl $PATH'
alias pathsed='sed "s/ /\n/g" <<< "$path"'

# TODO: get description
alias psa="ps auxwww"
alias px='ps uxa | more'

# exit or quit a program (shortcut)
alias q='exit'
alias :q='logout'

# TODO: get description
alias rm='rm -v'

# enables aliases to be sudo’ed
# https://askubuntu.com/a/22043
alias sudo='sudo '

# local bins
alias theme='~/.local/bin/toggle-theme'

# get tree aliases, all and ignore .git and .venv dir
alias tree='tree --dirsfirst'
alias treee='tree -aI ".git|.env"'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# watch files
alias waf='watch -d ls -lAh'



#
# [2 `ls` Aliases
#

# Always use color output for `ls`
# shellcheck disable=SC2139
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# detects which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then
  # linux flavor
  colorflag="--color"
else
  # OSX flavor
  colorflag="-G"
fi

# classify files in colors
alias ls="ls -hF ${colorflag}"

# TODO: get description
alias l='ls -CF'

# just a long list
# alias ll='ls -ahlF'
alias ll='ls -ltr'

# list all but . and ..
alias la='ls -lA'

# list all files colorized in long format
alias lc="ls -l ${colorflag}"

# list all files colorized in long format, dots too
alias lca="ls -la ${colorflag}"

# list only directories
alias lsd='ls -lhf | grep --color=never "^d"'

# Sorts directories in top, colors, and prints `/` at directories:
alias lsdd="gls --color -h --group-directories-first -F"

# show all regular files
alias lsaf='ls -lAhp | grep -v /'

# show all files again
alias lsf='ls -p | grep -v /'

# show all the symbolic links
alias lss='ls -la . | grep "\->"'

# Check if `lsddd` exists and use it
# https://github.com/Peltoche/lsd
if hash lsddd 2>/dev/null; then
  alias ls='lsd'
  alias l='lsd -l'
  alias la='lsd -lA'

  # tree
  alias lt='lsd --tree'
  alias lat='lsd -lA --tree'

  # space
  alias las='lsd -lA --total-size'
  alias lats='lsd -lA --tree --total-size'
fi









#
# [2 Application Aliases
#
# alias slt='open -a "Sublime Text 2"'
# alias pstorm='open -a "Sublime Text 2"'

# docker status report
alias dps='docker ps'
alias dpsa='docker ps -a'

alias chrome='open /Applications/Google\ Chrome.app'
alias plistbuddy='/usr/libexec/PlistBuddy'             # listBuddy alias, because sometimes `defaults` just doesn’t cut it
alias subl='"/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"'
# alias subl="source '/Applications/Sublime Text 2.app/Contents/MacOS/Sublime Text 2'"
# alias subpacks="cd '/Library/Application Support/Sublime Text 2/Packages'"










#
# [3 System Helpers, Monitoring Aliases
#



# create a sleeper alert for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# clean various things on the computer
alias clean-erase='shred –vfzu –n 5'
alias clean-screenshots='rm "${HOME}"/Desktop/{Screenshot,screenshot_}*'
alias clean-trash='sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash'

# disk monitors and helpers
alias disk-space='du -hx -d 1'
alias disk-space-sort='f() {du -hx -d 1 "${1}" | sort -hr}; f'

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# shutdown the system or sleep
alias fuckoff='logout-sync && sudo shutdown -h now'
alias fuckoff4bit='systemctl suspend'

# update the vhosts for user
alias hosts='sudo vi /etc/hosts'

# review the HTTP traffic
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\\: .*|GET \\/.*\""
alias httpdumps='sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\"'

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# monitors
alias monitor='python3.9 -m bpytop'

# pretty print thing like $paths and xml and json
alias pp-fpath='echo $FPATH | tr -s ":" "\n"'
alias pp-path='echo $PATH | tr -s ":" "\n"'




# pid and process management | TODO: get description
alias pid-list='ps aux > pid.list && nvim pid.list'

# get some ip address details
alias ip-list='sudo ifconfig -a | grep -o "inet6\\? \\(addr:\\)\\?\\s\\?\\(\\(\\([0-9]\\+\\.\\)\\{3\\}[0-9]\\+\\)\\|[a-fA-F0-9:]\\+\\)" | awk "{ sub(/inet6? (addr:)? ?/, \"\"); print }"'
alias ip-local='sudo ifconfig | grep -Eo "inet (addr:)?([0-9]*\\.){3}[0-9]*" | grep -Eo "([0-9]*\\.){3}[0-9]*" | grep -v "127.0.0.1"'
alias ip-localip='ipconfig getifaddr en0'
alias ip-public='dig +short myip.opendns.com @resolver1.opendns.com'

# restart services like wifi, network, etc.
alias restart-wifi='nmcli radio wifi off && nmcli radio wifi on'
alias restart-wired='service network-manager restart'

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# start using these instead of emojis
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"

# view and sniff http traffic
alias sniff='lsof -i 4tcp'
alias sniffd="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"

# stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# tmux TODO: get description
alias ta='tmux a -t'
alias tka='tmux kill-server'
alias tks='tmux kill-session -t'
alias tls='tmux ls'
alias sw='start-workspace'






alias diskstat='watch -c -d -n 1 "sudo S_COLORS=always iostat -xmdzc -t 1 1"'
alias diskuse='watch -c -d -n 1 "sudo S_COLORS=always sar -d 0"'
alias fs='stat -f \"%z bytes\"'
alias flush="dscacheutil -flushcache"
alias grep='grep --color=auto '

alias iotop='sudo iotop -oa'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias localip="ipconfig getifaddr en1"
alias mpstat='watch -c -d -n 1 "sudo S_COLORS=always mpstat -P ALL"'
alias netuse='watch -c -d -n 1 "sudo S_COLORS=always sar -n DEV 0"'
alias p='ps aux | grep -v ]$'
alias pg='ps aux | head n1; ps aux | grep -i'
alias sc-dreload='sudo systemctl daemon-reload'

alias sudo='sudo '                          # http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias tf='tail -F -n200'
alias top='top -ocpu'
alias vmstat='vmstat -Sm 1'
alias whois="whois -h whois-servers.net"    # enhanced WHOIS lookups


alias dis='docker images --format "{{.Size}}\t{{.Repository}}:{{.Tag}}\t{{.ID}}" | sort -h'
alias dc='docker-compose'
alias fl='footloose'
alias tm='tmux new -A -s mySession'
alias tma='tmate new -A -s mySession'
alias yaegi='rlwrap yaegi'
alias dot='cd $HOME/.dotfiles'
alias query-manifest='qi'
alias tree='tree -sh --du --dirsfirst -F -A -C -I "out|node_modules|vendor|build"'

# Pretty print XML (use `jq` for json):
alias xq="xmllint --format"














#
# [4 Git Aliases
#

# TODO: get description
alias cdg='cd-gitroot'

# TODO: get description
alias g='git'

# add files and commit them
alias gac='git add . && git commit'

# show whats changed, staged and unstaged
alias gd='git diff HEAD'

# Initial empty commit for repos
alias ge='git init && git commit --allow-empty -m "Initial commit"'

# Visualize git branch tree
alias glvb='git log --graph --simplify-by-decoration --pretty=format:'%d' --all'

# show status of current git branch
alias gs='git status'

# git Stash
alias gstu='git stash -u'
alias gstum='git stash save -u -m'

# List tracked files by git
alias gtf='git ls-tree -r $(git_current_branch) --name-only'

# TODO: get description
alias gtree='git log --graph --full-history --all --color --pretty=format:"%x1b[33m%h%x09%x09%x1b[32m%d%x1b[0m %x1b[34m%an%x1b[0m   %s" "$@"'






# `bat` styling:
alias bat="\bat --theme=GitHub"



#
# [5 Tools, Shortcuts, Miscellaneous Aliases
#

# remove the dollar sign when cp '$'
# alias '$'=''

# going away from keyboard for a bit (lock screen)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"



# get some different dates
alias dt-day='date "+%Y%m%d%"'
alias dt-time='date "+%Y%m%d%H%M%S"'
alias dt-week='date +%V'

# change directories to the dotfiles
alias dots='cd "${HOME}"/.dotfiles'

alias get="wget --no-clobber --page-requisites --html-extension --convert-links --no-host-directories"
alias hosts='sudo vim /etc/hosts'
alias line="sed -n '\''\!:1 p'\'' \!:2" # show line 5 of file
alias pull="curl -O -L"
alias reload='source "${HOME}"/.bash_profile && echo "sourced ~/.bash_profile"'
alias stfu='osascript -e "set volume output muted true"'
alias tits='growlnotify -a "Activity Monitor" "System error" -m "Testing this."'
alias trimcopy="tr -d '\n' | pbcopy"
alias updot='printf "Updating dotfiles."'
alias updots='source ~/.updates | tee ~/dotfiles/getupdates.log'


# pipe ssh keys to the clipboard
alias prikey="more ~/.ssh/id_ed25519 | xclip -selection clipboard | echo '=> Private key copied to pasteboard.'"
alias pubkey="more ~/.ssh/id_ed25519.pub | xclip -selection clipboard | echo '=> Public key copied to pasteboard.'"
alias key-pub='cat ~/.ssh/id_rsa.pub | pbcopy | echo "=> Public key copied to pasteboard."'

alias prpg="LC_CTYPE=C tr -dc 'A-Za-z0-9_-' < /dev/urandom | fold -w 16 | head -n1"

# compressing and uncompressing files
alias untar='tar xvf'



#
# [6 MacOS Aliases
#

# macOS
# do these need to be moved?
alias binge='brew update && brew upgrade && brew upgrade --cask && brew cleanup'
alias brewdeps='brew list --formula -1 | while read cask; do echo -ne "\x1B[1;34m $cask \x1B[0m"; brew uses $cask --installed | awk '"'"'{printf(" %s ", $0)}'"'"'; echo ""; done'

# recursively delete the annoying `.DS_Store` files
alias cleanup='find . -type f -name "*.DS_Store" -ls -delete'

# empty the Trash on all mounted volumes and the main HDD
# also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Decode base64 string from the clipboard
alias clipdecode="pbpaste|base64 --decode"

# Flush Directory Service cache
alias flushdns='dscacheutil -flushcache && ps aux|grep mDNSResponder |grep -v grep |awk '"'"'{print $2}'"'"' |xargs sudo kill -HUP'

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
# [6 Linux OS
#
