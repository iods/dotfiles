#!/bin/bash
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#

# umask 0022

# include all environment configurations
if [ -f "${HOME}/.env" ]; then
  source "${HOME}/.env"
fi

# set PATH for a private bin for executables
if [ -d "${HOME}/.dotfiles/bin" ]; then
  PATH="${HOME}/.dotfiles/bin:$PATH"
fi

# set PATH for a private bin for executables
if [ -d "${HOME}/.local/bin" ]; then
  PATH="${HOME}/.local/bin:$PATH"
fi

# oh-my-zsh
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# shellcheck .bashrc and include it
if [ -f "${HOME}/.bashrc" ]; then
  source "${HOME}/.bashrc"
fi
