#!/bin/bash
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# Executed by bash when login shell exits.
#
# TODO:
#   - one
#   - two
#
# Version 0.2.1 [2024-10-31]
# http://github.com/iods/dotfiles
# Copyright (c) 2023-Present, Rye Miller

# when leaving the console clear the screen to increase privacy
if [[ "$SHLVL" == 1 ]]; then
    [[ -x /usr/bin/clear_console ]] && /usr/bin/clear_console -q
fi
