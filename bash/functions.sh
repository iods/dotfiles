#!/bin/bash
#
# Custom functions for daily tasks.
#
# http://github.com/iods/dotfiles
# Copyright (c) 2022, Rye Miller and the Dark Society
#
# echo "Loaded [8] last."


# Functions when required functionality won't work with an alias

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 4); do /usr/bin/time $shell -i -c exit; done
}

function update() {
    if [ "$(uname -s)" == "Linux" ]; then
        bash -c "$HOME/.dotfiles/setup_linux.sh"
    elif [ "$(uname -s)" == "Darwin" ]; then
        bash -c "$HOME/.dotfiles/setup_mac.sh"
    fi
}

# Generate a scp command to copy files between hosts
function scppath () {
    if [ "$#" -ne 1 ]; then
        echo "Illegal number of parameters. Call function with file name."
        echo "E.g. $0 myfile"
        return
    fi
if [ "$(uname -s)" == "Linux" ]; then
        IP=$(hostname -I | awk '{print $1}')
    elif [ "$(uname -s)" == "Darwin" ]; then
        IP=$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}' |head -1)
    fi

    echo "$USER"@"$IP":"$(readlink -f "$1")"
}

# Quickly find files by name
function f () {
    if [ "$#" -ne 1 ]; then
        echo "Illegal number of parameters. Call function with file name or wildcard."
        echo "E.g. $0 *.pdf"
        return
    fi
    name=$1
    shift
    find . -name "$name" "$@"
}

# Call journalctl for process or all if no arguments
function jo () {
    if [[ "$1" != "" ]]; then
        sudo journalctl -xef -u "$1";
    else
        sudo journalctl -xef;
    fi
}


# Generate a patch email from git commits
function gpatch () {
    if [[ "$1" != "" ]]; then
        git format-patch HEAD~"$1"
    else
        git format-patch HEAD~
    fi
}

# Send patch file with git
function gsendpatch () {
  echo 'If replying to an existing message, add "--in-reply-to messageIDfromMessage@somehostname.com" param'
  patch=$1
  shift
  git send-email \
    --cc-cmd="./scripts/get_maintainer.pl --norolestats $patch" \
    "$@" "$patch"
}

# Query Docker image manifest
function qi () {
    if [ "$#" -lt 1 ]; then
        echo "Illegal number of parameters. Call function with image name."
        echo "E.g. $0 repo/image"
        return
    fi
    echo "Querying image $1"
    if docker manifest inspect "$1" | jq -r '.manifests[] | [.platform.os, .platform.architecture] |@csv' 2> /dev/null | sed -E 's/\"(.*)\",\"(.*)\"/- \1\/\2/g' | grep -v '^/$'; then
        echo "$OUT"
    else
        echo "Image does not have a multiarch manifest."
    fi
}

# Execute ripgrep output thru pager
function rg() {
   command rg -p "$@" | less -FRX
}

# Install latest Golang. Replaces current one on /usr/local/go
function install_golang() {
    function install() {
        if ldd --version 2>&1 | grep -i musl > /dev/null; then
            echo "ERROR: Distro not supported for Go."
            return 1
        fi
        declare -A ARCH=( [x86_64]=amd64 [aarch64]=arm64 [armv7l]=arm [ppc64le]=ppc64le [s390x]=s390x )
        pushd /tmp >/dev/null || return
        FILE=$(curl -sL https://golang.org/dl/?mode=json | grep -E 'go[0-9\.]+' | sed 's/.*\(go.*\.tar\.gz\).*/\1/' | sort -n | grep -i "$(uname -s)" | grep tar | grep "${ARCH[$(uname -m)]}" | tail -1)
        CURRENT_VERSION=$(go version | grep -Po "go[0-9]\.[0-9]+\.[0-9]+")
        NEW_VERSION=$(echo "$FILE" | grep -Po "go[0-9]\.[0-9]+\.[0-9]+")
        if [ "$CURRENT_VERSION" == "$NEW_VERSION" ]; then
            echo "Go version $CURRENT_VERSION already installed."
            return 0
        fi
        echo "Installing $FILE"
        curl -sL https://dl.google.com/go/"$FILE" -o "$FILE"
        sudo rm -rf /usr/local/go
        sudo tar xf "$FILE" -C /usr/local/ 2>/dev/null
        rm -rf "$FILE"
        popd >/dev/null || return
    }
    install && echo "Installed $FILE" || echo "Error installing Go"
}

# Searches SSH hosts thru fzf and connects to it
function ss() {
    filter=${1:-"."}
    target=$(grep -E -o "Host (\b.+\b)" ~/.ssh/config | awk '{print $2}' | grep "$filter" | fzf -e)
    if [ "$target" ]; then
        echo "Remoting into: $target"
        ssh "$target"
    fi
}

# Return latest Github release
# Usage: lgr <owner/repo> <additional_grep_filter>
lgr() {
    if [ "$#" -lt 1 ]; then
        echo "Illegal number of parameters. Call function with author/repo."
        echo "E.g. $0 author/repository"
        return
    fi
    repo=https://api.github.com/repos/${1}/releases/latest

    # Additional grep filter
    FILTER=""
    if [ -n "${3+set}" ]; then
        FILTER="$3"
    fi

    VERSION=$(curl -s "${repo}" | grep "tag_name" | cut -d '"' -f 4 | grep "${FILTER}")
    echo "${VERSION}"
}

# Download Github release
# Usage: dlgr <owner/repo> <output_name> <additional_grep_filter>
dlgr() {
    if [ "$#" -lt 1 ]; then
        echo "Illegal number of parameters. Call function with author/repo."
        echo "E.g. $0 author/repository"
        return
    fi
    repo=https://api.github.com/repos/${1}/releases/latest

    # Additional grep filter
    FILTER=""
    if [ -n "${3+set}" ]; then
        FILTER="$3"
    fi

    URL=$(curl -s "${repo}" | grep "$(uname | tr LD ld)" |grep "$(uname -m)" | grep "browser_download_url" | cut -d '"' -f 4 | grep "${FILTER}" |grep -v "\(sha256\|md5\|sha1\)")
    FILENAME="$(echo ${URL} | rev | cut -d/ -f1 | rev)"
    OUT="${FILENAME}"
    if [ "${URL}" ]; then
        if [ -n "${2+set}" ]; then
            if [[ "${FILENAME}" == *gz ]]; then
                OUT=$(echo "$2" | awk '{$1=$1};1').gz
            else
                OUT=$(echo "$2" | awk '{$1=$1};1')
            fi
        fi
        curl -s -o "${OUT}" -OL "${URL}"
    else
        return 1
    fi
    if [[ "${FILENAME}" == *gz ]]; then
        gzip -d "${OUT}"
    fi
}

# Checkout last tag
gcolast() {
    LASTTAG=git describe --tags "$(git rev-list --tags --max-count=1)"
    git checkout "$LASTTAG"
}

# Load GTKWave in the background
gtkw() {
    BIN=/Applications/gtkwave.app/Contents/Resources/bin/gtkwave
    if test -f "./GTKwave/gtkwave.tcl"; then
        $BIN -S "./GTKwave/gtkwave.tcl" "$@" &
    elif test -f "$HOME/.dotfiles/rc/gtkwave.tcl"; then
        $BIN -S "$HOME/.dotfiles/rc/gtkwave.tcl" "$@" &
    else
        $BIN "$@" &
    fi
}

gtkwave() {
    BIN=/Applications/gtkwave.app/Contents/Resources/bin/gtkwave
    if test -f "./GTKwave/GTKWave.gtkw"; then
        $BIN "$@" "./GTKwave/GTKWave.gtkw" &
    else
        $BIN "$@" &
    fi
}

# Find the completion function
completion() {
    functions $_comps[${1}]
}

# Reload completion for command
reloadcomp() {
    unfunction "_${1}" && autoload -U "_${1}"
}

# Run silicon with code from clipboard. Puts image into clibboard
# Parameter 1 is the highlight language
siclip() {
    silicon --from-clipboard -l "${1:-bash}" --to-clipboard
}

# Git diff with Delta side-by-side
gdd() {
  preview=("git diff $@ --color=always -- {-1} | delta --side-by-side --width ${FZF_PREVIEW_COLUMNS-$COLUMNS}")
  git diff "$@" --name-only | fzf -m --ansi --height 100% --preview-window='up:75%' --cycle --reverse --exact --border --preview "${preview[@]}"
}

#
# F
#

# find a file in the current dir who's name matches provided string
function ff() {
  find . -name "$@"
}

# find a file in the current dir who's name starts with provided string
function ffsw() {
  find . -name "$@" '*'
}

# find a file in the current dir who's name ends with provided string
function ffew() {
  find . -name '*' "$@"
}

# find the file size or folder size
function fs() {
  if du -b /dev/null >/dev/null 2>&1; then
    local arg="-sbh"
  else
    local arg="-sh"
  fi
  # shellcheck disable=SC2199
  if [[ -n "$@" ]]; then
    du "${arg}" -- "$@"
  else
    du "${arg}" .[^.]* ./*
  fi
}


#
# H
#

# tell me what to eat i am too hungry to decide
function hungry() {
  echo "Freddys,Applebees,Nothing,Jersey Mikes,Arbys" | tr ',' '\n' | gshuf | head -1;
}


# make directory and immediately change into it
function mkd() {
  mkdir -p "$@" && cd "$_" || exit
}

# search a keyword in a given directory
function search() {
  str="${1}"
  dir="."
  if [[ -n "${2}" ]]; then
    dir="${2}"
  fi
  grep -rin "${str}" "${dir}"
}

#
# T
#
function trash() {
  (mv "$@" "${HOME}/.Trash")
}


#
# U
#
# OS X only:
# "o file.txt" = open file in default app.
# "o http://example.com" = open URL in default browser.
# "o" = open pwd in Finder.

function o {
  open ${@:-'.'}
}


# "git commit only"
# Commits only what's in the index (what's been "git add"ed).
# When given an argument, uses that for a message.
# With no argument, opens an editor that also shows the diff (-v).

function gco {
  if [ -z "$1" ]; then
    git commit -v
  else
    git commit -m "$1"
  fi
}


# "git commit all"
# Commits all changes, deletions and additions.
# When given an argument, uses that for a message.
# With no argument, opens an editor that also shows the diff (-v).

function gca {
  git add --all && gco "$1"
}


# "git get"
# Clones the given repo and then cd:s into that directory.
function gget {
  git clone $1 && cd $(basename $1 .git)
}


#!/usr/bin/env bash

# `.functions` provides helper functions for shell.
#
# This file is used as a part of `.shell_env`


# === Commonly used functions ===

pyclean () {
  # Cleans py[cod] and __pychache__ dirs in the current tree:
  find . | grep -E "(__pycache__|\.py[cod]$)" | xargs rm -rf
}


git-dowloadfolder () {
  # Downloads folder from git repository.
  url="$1"
  svn checkout ${url/tree\/master/trunk}
}


mc () {
  # Create a new directory and enter it
  mkdir -p "$@" && cd "$@"
}


cdf () {
  # cd into whatever is the forefront Finder window.
  local path=$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')
  echo "$path"
  cd "$path"
}


# From Dan Ryan's blog - http://danryan.co/using-antigen-for-zsh.html
man () {
  # Shows pretty `man` page.
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}


# Loads `.env` file from a filename passed as an argument
loadenv () {
  while read line; do
    if [ "${line:0:1}" = '#' ]; then
      continue  # comments are ignored
    fi
    export $line > /dev/null
  done < "$1"
  echo 'Loaded!'
}


# Sets up all my working env
workon () {
  if _z 2>&1 "$1"; then
    source '.venv/bin/activate' || true  # There might be no `.venv`
    code .
  fi
}




# Print working file.
#
#     henrik@Henrik ~/.dotfiles[master]$ pwf ackrc
#     /Users/henrik/.dotfiles/ackrc

function pwf {
  echo "$PWD/$1"
}


# Create directory and cd to it.
#
#     henrik@Nyx /tmp$ mcd foo/bar/baz
#     henrik@Nyx /tmp/foo/bar/baz$

function mcd {
  mkdir -p "$1" && cd "$1"
}


# SSH to the given machine and add your id_rsa.pub or id_dsa.pub to authorized_keys.
#
#     henrik@Nyx ~$ sshkey hyper
#     Password:
#     sshkey done.

function sshkey {
  ssh $1 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < ~/.ssh/id_?sa.pub  # '?sa' is a glob, not a typo!
  echo "sshkey done."
}


# Attach or create a tmux session.
#
# You can provide a name as the first argument, otherwise it defaults to the current directory name.
# The argument tab completes among existing tmux session names.
#
# Example usage:
#
#   tat some-project
#
#   tat s<tab>
#
#   cd some-project
#   tat
#
# Based on https://github.com/thoughtbot/dotfiles/blob/master/bin/tat
# and http://krauspe.eu/r/tmux/comments/25mnr7/how_to_switch_sessions_faster_preferably_with/

function tat() {
  session_name=`basename ${1:-$PWD}`
  session_name=${session_name/auctionet_/an_}
  session_name=${session_name//\./_}
  tmux new-session -As "$session_name"
}

function _tmux_complete_session() {
  local IFS=$'\n'
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( ${COMPREPLY[@]:-} $(compgen -W "$(tmux -q list-sessions | cut -f 1 -d ':')" -- "${cur}") )
}
complete -F _tmux_complete_session tat




#!/bin/bash

# Simple calculator
calc() {
	local result=""
	result="$(printf "scale=10;%s\\n" "$*" | bc --mathlib | tr -d '\\\n')"
	#						└─ default (when `--mathlib` is used) is 20

	if [[ "$result" == *.* ]]; then
		# improve the output for decimal numbers
		# add "0" for cases like ".5"
		# add "0" for cases like "-.5"
		# remove trailing zeros
		printf "%s" "$result" |
			sed -e 's/^\./0./'  \
			-e 's/^-\./-0./' \
			-e 's/0*$//;s/\.$//'
	else
		printf "%s" "$result"
	fi
	printf "\\n"
}

# Create a new directory and enter it
mkd() {
	mkdir -p "$@"
	cd "$@" || exit
}

# Make a temporary directory and enter it
tmpd() {
	local dir
	if [ $# -eq 0 ]; then
		dir=$(mktemp -d)
	else
		dir=$(mktemp -d -t "${1}.XXXXXXXXXX")
	fi
	cd "$dir" || exit
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
targz() {
	local tmpFile="${1%/}.tar"
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${1}" || return 1

	size=$(
	stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
	stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
	)

	local cmd=""
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli"
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz"
		else
			cmd="gzip"
		fi
	fi

	echo "Compressing .tar using \`${cmd}\`…"
	"${cmd}" -v "${tmpFile}" || return 1
	[ -f "${tmpFile}" ] && rm "${tmpFile}"
	echo "${tmpFile}.gz created successfully."
}

# Determine size of a file or total size of a directory
fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	# shellcheck disable=SC2199
	if [[ -n "$@" ]]; then
		du $arg -- "$@"
	else
		du $arg -- .[^.]* *
	fi
}

# Use Git’s colored diff when available
if hash git &>/dev/null ; then
	diff() {
		git diff --no-index --color-words "$@"
	}
fi

# Create a data URL from a file
dataurl() {
	local mimeType
	mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Create a git.io short URL
gitio() {
	if [ -z "${1}" ] || [ -z "${2}" ]; then
		echo "Usage: \`gitio slug url\`"
		return 1
	fi
	curl -i https://git.io/ -F "url=${2}" -F "code=${1}"
}

# Start an HTTP server from a directory, optionally specifying the port
server() {
	local port="${1:-8000}"
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Compare original and gzipped file size
gz() {
	local origsize
	origsize=$(wc -c < "$1")
	local gzipsize
	gzipsize=$(gzip -c "$1" | wc -c)
	local ratio
	ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)
	printf "orig: %d bytes\\n" "$origsize"
	printf "gzip: %d bytes (%2.2f%%)\\n" "$gzipsize" "$ratio"
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
json() {
	if [ -t 0 ]; then # argument
		python -mjson.tool <<< "$*" | pygmentize -l javascript
	else # pipe
		python -mjson.tool | pygmentize -l javascript
	fi
}

# Run `dig` and display the most useful info
digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}

# Query Wikipedia via console over DNS
mwiki() {
	dig +short txt "$*".wp.dg.cx
}

# UTF-8-encode a string of Unicode symbols
escape() {
	local args
	mapfile -t args < <(printf "%s" "$*" | xxd -p -c1 -u)
	printf "\\\\x%s" "${args[@]}"
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi
}

# Decode \x{ABCD}-style Unicode escape sequences
unidecode() {
	perl -e "binmode(STDOUT, ':utf8'); print \"$*\""
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi
}

# Get a character’s Unicode code point
codepoint() {
	perl -e "use utf8; print sprintf('U+%04X', ord(\"$*\"))"
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified."
		return 1
	fi

	local domain="${1}"
	echo "Testing ${domain}…"
	echo ""; # newline

	local tmp
	tmp=$(echo -e "GET / HTTP/1.0\\nEOT" \
		| openssl s_client -connect "${domain}:443" 2>&1)

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText
		certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_header, no_serial, no_version, \
			no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux")
		echo "Common Name:"
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//"
		echo ""; # newline
		echo "Subject Alternative Name(s):"
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\\n" | tail -n +2
		return 0
	else
		echo "ERROR: Certificate not found."
		return 1
	fi
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
v() {
	if [ $# -eq 0 ]; then
		vim .
	else
		vim "$@"
	fi
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
o() {
	if [ $# -eq 0 ]; then
		xdg-open .	> /dev/null 2>&1
	else
		xdg-open "$@" > /dev/null 2>&1
	fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre() {
	tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
}

# Call from a local repo to open the repository on github/bitbucket in browser
# Modified version of https://github.com/zeke/ghwd
repo() {
	# Figure out github repo base URL
	local base_url
	base_url=$(git config --get remote.origin.url)
	base_url=${base_url%\.git} # remove .git from end of string

	# Fix git@github.com: URLs
	base_url=${base_url//git@github\.com:/https:\/\/github\.com\/}

	# Fix git://github.com URLS
	base_url=${base_url//git:\/\/github\.com/https:\/\/github\.com\/}

	# Fix git@bitbucket.org: URLs
	base_url=${base_url//git@bitbucket.org:/https:\/\/bitbucket\.org\/}

	# Fix git@gitlab.com: URLs
	base_url=${base_url//git@gitlab\.com:/https:\/\/gitlab\.com\/}

	# Validate that this folder is a git folder
	if ! git branch 2>/dev/null 1>&2 ; then
		echo "Not a git repo!"
		exit $?
	fi

	# Find current directory relative to .git parent
	full_path=$(pwd)
	git_base_path=$(cd "./$(git rev-parse --show-cdup)" || exit 1; pwd)
	relative_path=${full_path#$git_base_path} # remove leading git_base_path from working directory

	# If filename argument is present, append it
	if [ "$1" ]; then
		relative_path="$relative_path/$1"
	fi

	# Figure out current git branch
	# git_where=$(command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
	git_where=$(command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null

	# Remove cruft from branchname
	branch=${git_where#refs\/heads\/}
	branch=${branch#remotes\/origin\/}

	[[ $base_url == *bitbucket* ]] && tree="src" || tree="tree"
	url="$base_url/$tree/$branch$relative_path"


	echo "Calling $(type open) for $url"

	open "$url" &> /dev/null || (echo "Using $(type open) to open URL failed." && exit 1);
}

# Get colors in manual pages
man() {
	env \
		LESS_TERMCAP_mb="$(printf '\e[1;31m')" \
		LESS_TERMCAP_md="$(printf '\e[1;31m')" \
		LESS_TERMCAP_me="$(printf '\e[0m')" \
		LESS_TERMCAP_se="$(printf '\e[0m')" \
		LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
		LESS_TERMCAP_ue="$(printf '\e[0m')" \
		LESS_TERMCAP_us="$(printf '\e[1;32m')" \
		man "$@"
}

# Use feh to nicely view images
openimage() {
	local types='*.jpg *.JPG *.png *.PNG *.gif *.GIF *.jpeg *.JPEG'

	cd "$(dirname "$1")" || exit
	local file
	file=$(basename "$1")

	feh -q "$types" --auto-zoom \
		--sort filename --borderless \
		--scale-down --draw-filename \
		--image-bg black \
		--start-at "$file"
}

# get dbus session
dbs() {
	local t=$1
	if [[  -z "$t" ]]; then
		local t="session"
	fi

	dbus-send --$t --dest=org.freedesktop.DBus \
		--type=method_call	--print-reply \
		/org/freedesktop/DBus org.freedesktop.DBus.ListNames
}

# check if uri is up
isup() {
	local uri=$1

	if curl -s --head  --request GET "$uri" | grep "200 OK" > /dev/null ; then
		notify-send --urgency=critical "$uri is down"
	else
		notify-send --urgency=low "$uri is up"
	fi
}

# build go static binary from root of project
gostatic(){
	local dir=$1
	local arg=$2

	if [[ -z $dir ]]; then
		dir=$(pwd)
	fi

	local name
	name=$(basename "$dir")
	(
	cd "$dir" || exit
	export GOOS=linux
	echo "Building static binary for $name in $dir"

	case $arg in
		"netgo")
			set -x
			go build -a \
				-tags 'netgo static_build' \
				-installsuffix netgo \
				-ldflags "-w" \
				-o "$name" .
			;;
		"cgo")
			set -x
			CGO_ENABLED=1 go build -a \
				-tags 'cgo static_build' \
				-ldflags "-w -extldflags -static" \
				-o "$name" .
			;;
		*)
			set -x
			CGO_ENABLED=0 go build -a \
				-installsuffix cgo \
				-ldflags "-w" \
				-o "$name" .
			;;
	esac
	)
}

# go to a folder easily in your gopath
gogo(){
	local d=$1

	if [[ -z $d ]]; then
		echo "You need to specify a project name."
		return 1
	fi

	if [[ "$d" == github* ]]; then
		d=$(echo "$d" | sed 's/.*\///')
	fi
	d=${d%/}

	# search for the project dir in the GOPATH
	mapfile -t path < <(find "${GOPATH}/src" \( -type d -o -type l \) -iname "$d"  | awk '{print length, $0;}' | sort -n | awk '{print $2}')

	if [ "${path[0]}" == "" ] || [ "${path[*]}" == "" ]; then
		echo "Could not find a directory named $d in $GOPATH"
		echo "Maybe you need to 'go get' it ;)"
		return 1
	fi

	# enter the first path found
	cd "${path[0]}" || return 1
}

golistdeps(){
	(
	if [[ -n "$1" ]]; then
		gogo "$@"
	fi

	go list -e -f '{{join .Deps "\n"}}' ./... | xargs go list -e -f '{{if not .Standard}}{{.ImportPath}}{{end}}'
	)
}

# get the name of a x window
xname(){
	local window_id=$1

	if [[ -z $window_id ]]; then
		echo "Please specifiy a window id, you find this with 'xwininfo'"

		return 1
	fi

	local match_string='".*"'
	local match_qstring='"[^"\\]*(\\.[^"\\]*)*"' # NOTE: Adds 1 backreference

	# get the name
	xprop -id "$window_id" | \
		sed -nr \
		-e "s/^WM_CLASS\\(STRING\\) = ($match_qstring), ($match_qstring)$/instance=\\1\\nclass=\\3/p" \
		-e "s/^WM_WINDOW_ROLE\\(STRING\\) = ($match_qstring)$/window_role=\\1/p" \
		-e "/^WM_NAME\\(STRING\\) = ($match_string)$/{s//title=\\1/; h}" \
		-e "/^_NET_WM_NAME\\(UTF8_STRING\\) = ($match_qstring)$/{s//title=\\1/; h}" \
		-e "\${g; p}"
}

govendorcheck() {
	# shellcheck disable=SC2046
	vendorcheck -u ./... | awk '{print $NF}' | sed -e "s#^github.com/jessfraz/$(basename $(pwd))/##"
}

restart_gpgagent(){
	# Restart the gpg agent.
	echo "Restarting gpg-agent and scdaemon..."
	echo -e "\tgpg-agent: $(pgrep gpg-agent) | scdaemon: $(pgrep scdaemon)"

	echo "Killing processes..."
	# shellcheck disable=SC2046
	kill -9 $(pgrep scdaemon) $(pgrep gpg-agent) >/dev/null 2>&1
	echo -e "\tgpg-agent: $(pgrep gpg-agent) | scdaemon: $(pgrep scdaemon)"

	gpgconf --reload gpg-agent
	gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

	echo "Restarted gpg-agent and scdaemon..."
}

gitsetoriginnopush() {
	git remote set-url --push origin no_push
}

get_cad_exchanger_token() {
	resp=$(curl -XPOST -sSL -H "Authorization: Basic $CAD_EXCHANGER_REQUEST_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{"grant_type":"client_credentials","scope":"data:read data:write data:create data:convert data:share viewer:read"}' \
		https://cloud.cadexchanger.com/api/v1/oauth2/token)
	echo "$resp" | jq --raw-output '.access_token'
}

cad_upload_folder_contents() {
	token=$(get_cad_exchanger_token)
	# Run this inside the folder with all the files.
	dir_name="rack-$(date '+%Y-%m-%d')"
	# Create the folder
	resp=$(curl -sSL -XPOST -H "Authorization: Bearer ${token}" \
        -H "Content-Type: application/json" \
        -d '{"folder": {"name":"'"${dir_name}"'", "parentFolder":"'"${CAD_EXCHANGER_PARENT_FOLDER}"'"}}' \
		https://cloud.cadexchanger.com/api/v1/folders)
	folder_id=$(echo "$resp" | jq --raw-output '.folder.id')

	for file in *.{SLDPRT,SLDASM}; do
		# Upload the file to the folder
		echo "Uploading $file..."
		set -x
		curl -sSL -XPOST -H "Authorization: Bearer ${token}" \
        	-F "parentFolder=${folder_id}" \
        	-F "data=@${file}" \
        	https://cloud.cadexchanger.com/api/v1/files
		set +x
	done
}

cad_convert_rack_files_to_collada() {
	token=$(get_cad_exchanger_token)
	# Get the file we want.
	resp=$(curl -sSL -H "Authorization: Bearer ${token}" \
		"https://cloud.cadexchanger.com/api/v1/files?name[startsWith]=OXC0000040")
	rack_files=$(echo "$resp" | jq --raw-output '.files[] | @base64')

	# Iterate over the files.
	for row in $rack_files; do
    	_jq() {
     		echo "${row}" | base64 --decode | jq -r "${1}"
    	}

   		file_id=$(_jq '.id')
   		file_name=$(_jq '.name')
		if [[ "$file_name" == *SLDASM ]]; then
			echo ""
			echo "Converting file $file_name to collada..."

			# Get the status of the file.
			echo "File status:"
			resp=$(curl -sSL -H "Authorization: Bearer ${token}" \
				"https://cloud.cadexchanger.com/api/v1/files/${file_id}")
			revision_id=$(echo "$resp" | jq --raw-output '.file.activeRevision')
			echo "$resp" | jq .

			# Get the status of the revison.
			echo "Revision status:"
			curl -sSL -H "Authorization: Bearer ${token}" \
				"https://cloud.cadexchanger.com/api/v1/filerevisions/${revision_id}" | jq .

			# Convert the file to COLLADA.
			echo "Conversion response:"
			curl -sSL -XPOST -H "Authorization: Bearer ${token}" \
				-H "Content-Type: application/json" \
				-d '{"format": "collada", "extension": "dae"}' \
				"https://cloud.cadexchanger.com/api/v1/files/${file_id}/convert" | jq .
		fi
	done
}
