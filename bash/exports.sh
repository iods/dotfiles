#!/bin/bash
#
# TODO: write script description
#



export EDITOR='vim'                              # make vim the default editor

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'   # colored GCC warnings and errors


export HIST_TIME_FORMAT='%d/%m/%y %T ';          # TODO: get description

export LC_CTYPE="en_US.UTF-8"                    # Prefer US language and stick to UTF-8
export LC_ALL="en_US.UTF-8"                      # Prefer US language and stick to UTF-8
export LANG="en_US.UTF-8"                        # Prefer US language and stick to UTF-8

#
# Additional PATH exports
#
export PATH="$HOME/.dotfiles/bin:$PATH"          # dotfile commands and utils
export PATH="$PATH:$HOME/.composer/vendor/bin"   # set the Composer path
export PATH="$HOME/.local/bin:$PATH"             # profile cmd installs
export PATH="$HOME/google-cloud-sdk/bin:$PATH"   # Google Cloud SDK and CLI
export PATH="$HOME/google-cloud-sdk/bin:$PATH"
