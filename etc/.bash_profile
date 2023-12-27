#!/bin/bash
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# Loads some basic dotfile needs and shell customizations.

# if not running interactively, don't do anything
[ -z "${PS1}" ] && return

# load .bashrc from the dotfiles library.

[[ -s "$HOME/.profile" ]] && source "${HOME}/.profile"

# colorize grep
# @TODO move to exports
export GREP_OPTIONS='--color=auto'

# shellcheck .bashrc and others
if [ -f "$HOME/.bashrc" ]; then
    shellcheck source=/dev/null
    source="${HOME}/.bashrc"
fi


