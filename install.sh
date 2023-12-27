#!/bin/bash
#
# Installation file for compiling dotfiles to a local environment.
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# Based on the Shell Style Guide: https://google.github.io/styleguide/shellguide.html
#
# Requires: curl, jq, bc
#
# TODO:
#   - profile installation
#   - error handling
#   - color control
#   - flag to specify an entity_id
#   - rewrite to use websocket api
#
# Version 00.2.0 [2023-10-02]
# http://github.com/iods/dotfiles
# Copyright (c) 2023, Rye Miller

set -o errexit # exit on error
set -o nounset # no unset variables
set -o pipefail # pipelines cannot hide errors


# Pre-configuration for Dotfiles


# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# put ~/bin on PATH if you have it
test -d "$DOTFILES/bin" &&
PATH="$DOTFILES/bin:$PATH"


declare -xr UNAME_OUT="$(uname -s)"

declare -xr SOMEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -xr DIR="$(dirname "${BASH_SOURCE}")"

echo "${UNAME_OUT}"

echo "${SOMEDIR}"

echo "${DIR}"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi








#!/usr/bin/env bash

WD="$(pwd)"

BREW_DIR="/opt/homebrew"

# Install homebrew if we need to.
if [ -f "$BREW_DIR/bin/homebrew" ]; then
  echo "Homebrew already installed"
else
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install homebrew packages.
printf "Installing homebrew packages..."
"$BREW_DIR/bin/homebrew" tap homebrew/bundle > /dev/null
"$BREW_DIR/bin/homebrew" bundle --file="$DIR/Brewfile" --no-lock > /dev/null
echo "done."

# Symlink everything.
printf 'Linking items from %s to home directory...' "$DIR"
find "$DIR" -type d \( ! -regex '.*/\..*' \) -depth 1 | sed 's!.*/!!' | xargs stow --dir="$DIR" --target="$HOME" --restow
echo "done."

# fzf
"$BREW_DIR"/opt/fzf/install --no-bash --no-zsh --all

# Install vim plugins
if [ ! -d ~/.local/share/vim/pack/packager ]; then
  git clone https://github.com/kristijanhusak/vim-packager ~/.vim/pack/packager/opt/vim-packager
fi
mvim -f -c "call PackagerInit() | call packager#install({'on_finish': ':w! >>/dev/tty | quitall'})"

# Finally, go back to where we started.
cd "$WD" > /dev/null || exit 1
exit 0
