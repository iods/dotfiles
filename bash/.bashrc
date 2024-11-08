#!/bin/bash
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# Executed by bash(1) for non-login shells (also see .bash_profile); see also
# /usr/share/doc/bash/examples/startup-files (in the bash-doc package).
#
# TODO:
#   - one
#   - two
#
# Version 0.2.1 [2024-10-31]
# http://github.com/iods/dotfiles
# Copyright (c) 2023-Present, Rye Miller

# Quickly source any files if they exist.
function _source_if() {
	local file
	file="$1"
	[[ -f "${file}" ]] && . "${file}"
}

# history updates
# append to, not overwrite the history file
# shopt -s histappend

# stops dups and/or lines starting w/ spaces
HISTCONTROL="ignoreboth"

# number of commands to store in file
HISTFILESIZE="2500"

# ignores various commands
HISTIGNORE="[   ]*:&:bg:fg:exit"

# number of commands to store before older are removed
HISTSIZE="1500"

# prepend commands with a timestamp
HISTTIMEFORMAT="[%F %T]"

# append/save and reload the history after command finishes
# PROMPT_COMMAND="history -a; history -n"
# export PROMPT_COMMAND="$PROMPT_COMMAND; \history -a;"
PROMPT_COMMAND="$PROMPT_COMMAND; history -a; history -n"

# case-insensitive globbing (used with pathname expansion)
shopt -s nocaseglob

# recursive globbing
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# history
# path
# variables
# aliases
# prompt (zsh?)

# completion

# autocorrect typos in path names when using `cd`
# shopt -s cdspell

# view and visual updates
# check window size after each command, update LINES and COLUMNS if needed
# shopt -s checkwinsize
