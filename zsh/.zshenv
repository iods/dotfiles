#!/bin/bash
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# Environment stuff. Configurations only. No functions. Loaded first.
# Why not have this replace exports.sh?
# Why not have this replace variables.sh?

if [[ ("$SHLVL" -eq 1 && ! -o LOGIN || -z "${TMP}") ]]; then
  . "${HOME}/.bash_profile"
  . "${HOME}/.zprofile"
  . "${HOME}/.profile"
fi


setopt noglobalrcs

#
# XDG directory support
# https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
# TODO: get information
#
export XDG_BIN_HOME="${HOME}/.local/bin"         # Base XDG support for User binaries directory
export XDG_CACHE_HOME="${HOME}/.cache"           # Base XDG support for User cache directory
export XDG_CONFIG_HOME="${HOME}/.config"         # Base XDG support for User config directory
export XDG_DATA_HOME="${HOME}/.local/share"      # Base XDG support for User data directory
export XDG_LIB_HOME="${HOME}/.local/lib"         # Base XDG support for User lib directory

export XBIN="${XDG_BIN_HOME}"                    # Alias for the XDG home binaries directory
export XCACHE="${XDG_CACHE_HOME}"                # Alias for the XDG home cache directory
export XCONF="${XDG_CONFIG_HOME}"                # Alias for the XDG home config directory
export XDATA="${XDG_DATA_HOME}"                  # Alias for the XDG home data directory
export XLIB="${XDG_LIB_HOME}"                    # Alias for the XDG home lib directory

export ZSH_CUSTOM_DIR="${XDG_CONFIG_HOME}/zsh"   # XDG home directory

# Disable coredumps for systemd
# https://www.cyberciti.biz/faq/disable-core-dumps-in-linux-with-systemd-sysctl
ulimit -S -c 0

#
# NodeJS
#
# Change default ${HOME}/.npmrc userconfig file location
# https://docs.npmjs.com/cli/v8/using-npm/config#userconfig
export npm_config_userconfig="${XDG_CONFIG_HOME}/node/.npmrc"


#
# Enable Password Store
#
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

#
# Colors
#
export CLR_NONE="\e[0m"
export CLR_BLACK="\e[0;30m"
export CLR_DARK_GRAY="\e[1;30m"
export CLR_LIGHT_GRAY="\e[0;37m"
export CLR_WHITE="\e[1;37m"
export CLR_RED_LIGHT="\e[1;31m"
export CLR_RED="\e[0;31m"
export CLR_GREEN="\e[0;32m"
export CLR_GREEN_LIGHT="\e[1;32m"
export CLR_BROWN="\e[0;33m"
export CLR_YELLOW="\e[1;33m"
export CLR_BLUE="\e[0;34m"
export CLR_BLUE_LIGHT="\e[1;34m"
export CLR_PURPLE="\e[0;35m"
export CLR_PURPLE_LIGHT="\e[1;35m"
export CLR_CYAN="\e[0;36m"
export CLR_CYAN_LIGHT="\e[1;36m"



export GPG_TTY="$(tty)"




