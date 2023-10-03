#!/bin/bash
#
# Installation file for compiling dotfiles to a local environment.
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# Version 00.2.0 [2023-08-20]
# Based on the Shell Style Guide: https://google.github.io/styleguide/shellguide.html
#
# TODO:
#   - error handling
#   - color control
#   - flag to specify an entity_id
#   - rewrite to use websocket api

# Sets whether you are on your home machine
declare -xr IS_HOME_PC=false

declare -xr UNAME_OUT="$(uname -s)"

case "${UNAME_OUT}" in
  Linux*)
    MACHINE=Linux
    ;;
  Darwin*)
    MACHINE=Darwin
    ;;
  CYGWIN*)
    MACHINE=Cygwin
    ;;
  MINGW*)
    MACHINE=MinGw
    ;;
  *)
    MACHINE="Unknown: ${UNAME_OUT}"
    ;;
esac

# Return the Dotfiles working directory
readonly BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Return the current directory you are in
readonly TEST="$(readlink -f "$(dirname "${BASH_SOURCE:-$0}")")"

# Return the home directory
readonly INSTALL_TARGET="${HOME}"


echo "${TEST}"
echo "looks like we are running on a $MACHINE kernel."


# Test that the user has sudo privileges
# echo "Testing superuser privileges (password required)..."
# sudo echo 'Looks like you have the correct privileges. Lets get started!' || exit 1

