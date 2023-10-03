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

declare -xr UNAME_OUT="$(uname -s)"

declare -xr SOMEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "${UNAME_OUT}"

echo "${SOMEDIR}"