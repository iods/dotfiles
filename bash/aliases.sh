#!/bin/bash
#
# TODO: write script description
#

#
# Override Aliases
#
# alias -g P=''

#
# [1 Generic Aliases
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
  colorflag="--color" # leeeeeenux flavor
else
  colorflag="-G"      # OSX flavor
fi
alias lsd='ls -l | grep "^d"'               # list only directories
alias lsdd='ls -lhF ${colorflag} | grep --color=never "^d"'
alias ls="ls -hF ${colorflag}"              # classify files in colors
alias ll='ls -ltr'                          # just a long list
alias la='ls -lA'                           # list all but . and ..
alias lca="ls -la ${colorflag}"             # list all files colorized in long format, dots too
alias lc="ls -l ${colorflag}"               # list all files colorized in long format
alias l='ls -CF'                            # get description
alias df='df -h'                            # default to Human Readable Figures
alias du='du -h'                            # default to Human Readable Figures
# Sorts directories in top, colors, and prints `/` at directories:
alias lsdd="gls --color -h --group-directories-first -F"

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
alias gd='git diff HEAD'                    # show whats changed, staged and unstaged
alias gs='git status'                       # show status of current git branch
alias gtree='git log --graph --full-history --all --color --pretty=format:"%x1b[33m%h%x09%x09%x1b[32m%d%x1b[0m %x1b[34m%an%x1b[0m   %s" "$@"'
# `bat` styling:
alias bat="\bat --theme=GitHub"

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
alias updots='source ~/.updates | tee ~/dotfiles/getupdates.log'


#
# [6 Linux OS and Mac OSX Aliases
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




# Show local ip:
alias localip="ipconfig getifaddr en0"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Copy public key to clipboard:
alias pubkey="cat ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# I use this a lot:
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"


# List all files colorized in long format
# shellcheck disable=SC2139
alias l="ls -lhF ${colorflag}"

# List all files colorized in long format, including dot files
# shellcheck disable=SC2139
alias la="ls -lahF ${colorflag}"

# List only directories
# shellcheck disable=SC2139
alias lsd="ls -lhF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
# shellcheck disable=SC2139
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Always enable colored `grep` output
alias grep='grep --color=auto '

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Get week number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# IP addresses
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ips="sudo ifconfig -a | grep -o 'inet6\\? \\(addr:\\)\\?\\s\\?\\(\\(\\([0-9]\\+\\.\\)\\{3\\}[0-9]\\+\\)\\|[a-fA-F0-9:]\\+\\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\\: .*|GET \\/.*\""

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Trim new lines and copy to clipboard
alias c="tr -d '\\n' | xclip -selection clipboard"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	# shellcheck disable=SC2139,SC2140
	alias "$method"="lwp-request -m \"$method\""
done

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Lock the screen (when going AFK)
alias afk="i3lock -c 000000"

# vhosts
alias hosts='sudo vim /etc/hosts'

# copy working directory
alias cwd='pwd | tr -d "\r\n" | xclip -selection clipboard'

# copy file interactive
alias cp='cp -i'

# move file interactive
alias mv='mv -i'

# untar
alias untar='tar xvf'

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_ed25519.pub | xclip -selection clipboard | echo '=> Public key copied to pasteboard.'"

# Pipe my private key to my clipboard.
alias prikey="more ~/.ssh/id_ed25519 | xclip -selection clipboard | echo '=> Private key copied to pasteboard.'"

# Blender
alias blender='/Applications/Blender.app/Contents/MacOS/Blender'

# CAD exchanger
alias cad_exchanger='/Applications/CAD\ Exchanger.app/Contents/MacOS/ExchangerConv'



# handy aliases
alias ll='ls -l'
alias la='ls -hlA'
alias l='ls'
alias rm='rm -v'
alias df='df -h'
alias du='du -h'
alias grep="grep --color"
alias hist="history|tail"
alias psa="ps auxwww"

alias prpg="LC_CTYPE=C tr -dc 'A-Za-z0-9_-' < /dev/urandom | fold -w 16 | head -n1"

alias pry-watch='while clear && sleep 1; do pry-remote -w; done'

#aliases for my local stuff
alias ddate="date '+%Y%m%d%'"
alias cdate="date '+%Y%m%d%H%M%S'"
