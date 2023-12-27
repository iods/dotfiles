#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
#

# Test for interactive shell. No need to set anything past this point for scp
# and rcp, it's important to refrain from outputting anything in those cases.
case $- in
  *i*) ;; # shell is non-interactive.  be done now.
    *) return ;;
esac

# append and reload the history after each command
# https://metaredux.com/posts/2020/07/07/supercharge-your-bash-history.html
# PROMPT_COMMAND="history -a; history -n"

HISTCONTROL=ignoreboth           # stops duplicate or line starting w/ spaces in history
HISTFILESIZE=2000                # number of commands that are stored in a file
HISTIGNORE="[   ]*:&:bg:fg:exit" # ignore various commands
HISTSIZE=1000                    # number of commands before old ones get removed
HISTTIMEFORMAT="[%F %T] "        # prepend history entries with timestamps

# shopt -s histappend              # append to, don't overwrite the history file

# Save and reload the history after each command finishes
# export PROMPT_COMMAND="$PROMPT_COMMAND; \history -a;"

# autocorrect typos in path names when using `cd`
# shopt -s cdspell

# check window size after each command, update LINES and COLUMNS if needed
# shopt -s checkwinsize

# enable color support for ls and some aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls="ls --color=auto"
fi


# Aliases (all additions go at the end)
# to override an alias: `alias -g P=`
alias .='pwd'
alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../..'
alias 3.='cd ../../../'
alias 4.='cd ../../../../'


alias c='clear'
alias clr='clear'


alias shell-reset="source ~/.zshrc"

