#!/bin/bash
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# Executed for login shells. This file is not read by bash when ~/.bash_profile
# or ~/.bash_login exist.
#
# TODO:
#   - one
#   - two
#
# Version 0.2.1 [2024-10-31]
# http://github.com/iods/dotfiles
# Copyright (c) 2023-Present, Rye Miller

# default umask is set by /etc/profile
# umask 022

# include all environment specific configurations (exports, etc.)
if [ -f "${HOME}/.env" ]; then
	source "${file}/.env"
fi

# sets a PATH for a private bin for executables, if they exist.
if [ -d "${HOME}/.dotfiles/bin" ]; then
	PATH="${HOME}/.dotfiles/bin:$PATH"
fi

if [ -d "${HOME}/.local/bin" ]; then
	PATH="${HOME}/.local/bin:$PATH"
fi

# shellcheck .bashrc and include it
if [ -f "${HOME}/.bashrc" ]; then
	source "${HOME}/.bashrc"
fi

