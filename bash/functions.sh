#!/bin/bash
#
# Perform hot backups of Oracle databases.
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# Custom functions for daily tasks.
#
# http://github.com/iods/dotfiles
# Copyright (c) 2023, Rye Miller, The Dark Society
#
# echo "Loaded [8] last."
# ~/bash/functions.sh: executed by bash(1) when login shell exists.

# Functions for internal use, functionality will not work with alias.


# Return the current timezone
function getTz() {
    shell = ${1-$SHELL}
    for i in $(seq 1 4); do
        /usr/bin/time $shell -i -c exit;
    done
}


