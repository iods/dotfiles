#!/bin/bash
#
# Custom functions for daily tasks.
#
# http://github.com/iods/dotfiles
# Copyright (c) 2022, Rye Miller and the Dark Society
#
# echo "Loaded [8] last."


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
