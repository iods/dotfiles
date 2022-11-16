#!/bin/bash
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# # ~/.bashrc: executed by bash(1) for non-login shells (also see .bash_profile).
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# [ -n "$PS1" ] && source "${HOME}"/.bash_profile

# Test for interactive shell. No need to set anything past this point for scp
# and rcp, it's important to refrain from outputting anything in those cases.
case $- in
  *i*) ;; # shell is non-interactive.  be done now.
    *) return ;;
esac

# Quickly source available files.
# For settings on different machines, see .local.bashrc (i.e. PS1="[\u@\h \W]\$ ")
function source_file() {
  local file
  file="${1}"
  [[ -f "${file}" ]] && . "${file}"
}

# Quickly source available files if they exist
function _source_if() {
  local file
  file="${1}"
  [[ -f "${1}" ]] && . "${1}"
}


_source_if "${HOME}/dotfiles/configurations" # [1]
# history
# path
# vars
# aliases
# prompt
# completion


# functions
if [[ -d "${HOME}/dotfiles/bash" ]]; then
  _source_if "${HOME}/dotfiles/bash/functions.sh"
fi



# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        # Remove the directive once shellcheck is upgraded
        # shellcheck disable=SC1117
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac


# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
	-o "nospace" \
	-W "$(grep "^Host" ~/.ssh/config | \
	grep -v "[?*]" | cut -d " " -f2 | \
	tr ' ' '\n')" scp sftp ssh


# sourced on new screens, non-login shells.
# echo sourcing .bashrc

host=`uname -n | sed -e 's/\.lan$//g' -e 's/\.local$//g'`;
platform=`uname`;

# append and reload the history after each command
# Taken from https://metaredux.com/posts/2020/07/07/supercharge-your-bash-history.html
PROMPT_COMMAND="history -a; history -n"


export HISTIGNORE="[   ]*:&:bg:fg:exit"
# Prepend history entries with timestamps
export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history ( leave empty for unlimited )
export HISTFILESIZE=100000               # big big history (leave empty for unlimited )
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
# export PROMPT_COMMAND="$PROMPT_COMMAND; \history -a;"

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# Case-insensitive globbling (used with pathname expansion)
shopt -s nocaseglob

# Check the window size after each command and, if necessary, update
# the values of LINES and COLUMNS.
shopt -s checkwinsize



# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done


rpg(){
    size=${1:-12}; ruby -e "require 'securerandom'; puts SecureRandom.urlsafe_base64($size);"
}

git-rm-banch(){
    git branch -D $1 && git push origin :$1
}

basher(){
    env -i PATH=$PATH HOME=$HOME TERM=xterm-color "$(command -v bash)" --noprofile --norc
}

reset_known_host() {
    if [ "$1" != "" ]; then
        grep -v "$1" $HOME/.ssh/known_hosts > $HOME/.ssh/known_hosts.tmp
        mv -v $HOME/.ssh/known_hosts.tmp $HOME/.ssh/known_hosts
    else
        echo "No pattern provided"
    fi
}


# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	if [[ -z "$SSH_AUTH_SOCK" ]] || [[ "$SSH_AUTH_SOCK" == *"apple.launchd"* ]]; then
		SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
		export SSH_AUTH_SOCK
	fi
fi

# # We do this before the following so that all the paths work.
# for file in ~/.{bash_prompt,aliases,functions,path,dockerfunc,extra,exports}; do
# 	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
# 		# shellcheck source=/dev/null
# 		source "$file"
# 	fi
# done
# unset file

source_if_exists "$HOME/.bashrc.${platform}"
source_if_exists "$HOME/.bashrc.${host}"
source_if_exists "$HOME/.local/.bashrc"
# source ~/.bash/path.sh
# source ~/.bash/env.sh
# source ~/.bash/completion.sh
#
# source ~/.bash/aliases.sh
# source ~/.bash/functions.sh
# source ~/.bash/prompt.sh

# set +x
# exec 2>&3 3>&-

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

alias standup="subl ~/Documents/standup.md"
export EDITNOW='subl'
export EDITOR='subl -w'
export LESS="$LESS -i -F -R -X"

export CLICOLOR=1
export TERM=xterm-color

alias ls="/bin/ls -F"
alias git='hub'

# allow PUMA_DEV_BIN="./puma-dev" for installing dev versions
export PUMA_DEV_BIN='puma-dev'
alias puma-dev-setup="sudo $PUMA_DEV_BIN -d test:localhost:loc.al -setup"
alias puma-dev-install="$PUMA_DEV_BIN -d test:localhost:loc.al -install"
alias puma-dev-uninstall="$PUMA_DEV_BIN -uninstall -d test:localhost:loc.al"

puma-dev-ln () {
  echo ln -sf $1 "~/.puma-dev/$(basename $1)"
  echo ln -sf $1 "~/.puma-dev/$(basename $1).loc"
}

parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

uber_prompt() {
  local        BLUE="\[\033[0;34m\]"
  local      YELLOW="\[\033[0;33m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"

  PS1="$LIGHT_GRAY$*$GREEN\$(parse_git_branch)$LIGHT_GRAY\$ "
  PS2='> '
  PS4='+ '
}

uber_prompt "\h:\W"



# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PS1="\\[\\e]0;${debian_chroot:+($debian_chroot)}\\u@\\h: \\w\\a\\]$PS1"
		;;
	*)
		;;
esac


# {{{ Includes

for file in "${HOME}/.sh/inc"/*.sh; do
  # shellcheck source=/dev/null
  . "${file}"
done

# }}}

