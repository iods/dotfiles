#!/bin/bash
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# Executed in login shells (also see .bashrc) and loads some
# basic dotfile needs and shell customizations.
#
# TODO:
#   - one
#   - two
#
# Version 0.2.1 [2024-10-31]
# http://github.com/iods/dotfiles
# Copyright (c) 2023-Present, Rye Miller

# test for interactive shell. No need to set anything past this for scp/rcp
# as it is important to refrain from outputting anything in those cases. If
# running interactively, then return (exit).
case $~ in
	*i*) ;;
		*) return
		;;
esac

# read and execute anything related to globals or defaults.
[[ -s ~/.profile ]] && source ~/.profile
[[ -s ~/.bashrc ]] && source ~/.bashrc

# if not running interactively, don't do anything.
[ -z "${PS1}" ] && return

# read and execute anything related to globals or defaults.
[[ -s "$HOME/.profile" ]] && source "${HOME}/.profile"

# colorize grep
export GREP_OPTIONS='--color=auto'

# shellcheck .bashrc and any others.
if [ -f "$HOME/.bashrc" ]; then
	# shellcheck source=/dev/null
	# source="${HOME}/.bashrc"
fi

# set a hostname if not already available.
