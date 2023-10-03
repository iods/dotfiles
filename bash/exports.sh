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


====-----====|
#!/usr/bin/env bash

# `.exports` is used to provide custom variables.
#
# This file is used as a part of `.shell_env`


# === Compiler flags ===

# This is required because `openssl` is keg-only in `brew`,
# see: `brew info openssl` for more information.
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"


# === Path modifications ===

# These lines should be the first ones!

# GPG agent:
PATH="/usr/local/opt/gpg-agent/bin:$PATH"

# Adds `pipx` binary files:
PATH="$HOME/.local/bin:$PATH"

# Adds `poetry` binary, should be added to the end:
PATH="$HOME/.poetry/bin:$PATH"

# postgres@9.6 utilities like `psql`:
PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# npm:
PATH="/usr/local/share/npm/bin:$PATH"

# python2 (required by npm and other tools, installed via pyenv):
# PATH="$PATH:$HOME/.pyenv/versions/2.7.17/bin"


# === General ===

# Editor:
export EDITOR=$(which nano)

# GPG:
export GPG_TTY=$(tty)
eval "$(gpg-agent --daemon --allow-preset-passphrase > /dev/null 2>&1)"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8'

# Homebrew:
export HOMEBREW_NO_ANALYTICS=1  # disables statistics that brew collects

# Pagers:
# This affects every invocation of `less`.
#
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x4  tabs are 4 instead of 8
export LESS="-iRFXMx4"
export PAGER='less'
export MANPAGER='less'


# === Version managers ===

# nvm:
export NVM_DIR="$HOME/.nvm"
source "/usr/local/opt/nvm/nvm.sh"

# pyenv:
eval "$(pyenv init --path)"

# rbenv:
eval "$(rbenv init -)"

# rustup:
source "$HOME/.cargo/env"


# === Histories ===

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY="$HOME/.node_history"
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy'

# Erlang and Elixir shell history:
export ERL_AFLAGS="-kernel shell_history enabled"


# === Code highlight ===
# https://github.com/zsh-users/zsh-syntax-highlighting

# We won't highlight code longer than 200 chars, because it is slow:
export ZSH_HIGHLIGHT_MAXLENGTH=200


# === PATH ===

# This should be the last line:
export PATH


#!/usr/bin/env bash
# shellcheck disable=SC1091

# Load utility functions
source "$HOME/.dotfiles/utils.sh"

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=50000000;
export SAVEHIST=50000000;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;
# Make some commands not show up in history
export HISTIGNORE=" *:ls:cd:cd -:pwd:exit:date:* --help:* -h:pony:pony add *:pony update *:pony save *:pony ls:pony ls *:history*";
export HISTTIMEFORMAT="%d/%m/%y %T "

# Prefer US English and use UTF-8
export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export LESS="-FR"

# Don’t clear the screen after quitting a manual page
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Do not clear screen after exiting LESS
# unset LESS

# Make vim the default editor
export EDITOR="vim"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$YELLOW"

# Use bat as previewer for FZF
export FZF_DEFAULT_OPTS='--height "75%" --preview "bat --style=numbers --cycle --reverse --color=always --line-range :500 {}"'
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_CTRL_T_OPTS='--preview "bat --color=always --line-range :500 {}"'

# Add alt-up/down keybinding to fzf preview window
export FORGIT_FZF_DEFAULT_OPTS="
${FORGIT_FZF_DEFAULT_OPTS:-""}
--bind='alt-up:preview-up'
--bind='alt-down:preview-down'
--no-mouse
--preview-window='right:75%'
--exact
--border
--cycle
--reverse
--height '90%'
"
export FORGIT_LOG_FZF_OPTS="${FORGIT_FZF_DEFAULT_OPTS:-""} --height 100% --preview-window='up:50%'"

# Change fzf trigger from "**"
export FZF_COMPLETION_TRIGGER=';'

# Additional PATH exports
export PATH="$HOME/.dotfiles/bin:$PATH"
export PATH="$HOME/.dotfiles/bin/scala_scripts/:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
for d in /usr/local/opt/gnu-*; do
    export PATH="$d/libexec/gnubin:$PATH"
done
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$HOME/.cargo/bin:$PATH

## Golang path
export GOPATH=$HOME/go
export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH

# Add Erlang shell history and unicode messages
export ERL_AFLAGS="+pc unicode -kernel shell_history enabled -enable-feature all"

## Scala Coursier Path for Mac and Linux
export PATH="$HOME/Library/Application Support/Coursier/bin:$PATH"
export PATH="$HOME/.local/share/coursier/bin:$PATH"

# Add Java to path (if coursier is installed)
export JVM=graalvm-java17
JAVA_HOME=/usr/local/java
if [ -x "$(command -v cs)" ] ; then
    if [[ "$(cs java-home --jvm ${JVM} > /dev/null 2>&1)" -eq 0 ]]; then
        JAVA_HOME=$(cs java-home --jvm ${JVM})
    fi
    export JAVA_HOME
    if [ "$(uname -s)" == "Linux" ]; then # No need to add JAVA_HOME/bin on Mac
        export PATH=$JAVA_HOME/bin:$PATH
    fi
fi

# Ripgrep config
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# GPG
GPG_TTY=$(tty)
export GPG_TTY

# Set exa colors (https://the.exa.website/docs/colour-themes)
export EXA_COLORS="uu=1;36"




#!/bin/bash

# Set bash as our shell, idk why anyone would use something else ;)
shell="$(which bash)";
export SHELL="$shell";

# Make vim the default editor
export EDITOR=/usr/bin/vim;
export TERMINAL="urxvt";

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=50000000;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;
# Make some commands not show up in history
export HISTIGNORE=" *:ls:cd:cd -:pwd:exit:date:* --help:* -h:pony:pony add *:pony update *:pony save *:pony ls:pony ls *";

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X";

export DBUS_SESSION_BUS_ADDRESS
DBUS_SESSION_BUS_ADDRESS=unix:path=/var/run/user/$(id -u)/bus;

export TODOTXT_DEFAULT_ACTION=ls

# hidpi for gtk apps
export GDK_SCALE=1.5
export GDK_DPI_SCALE=0.5
export QT_DEVICE_PIXEL_RATIO=1.5

# turn on go vendoring experiment
export GO15VENDOREXPERIMENT=1

export DOCKER_CONTENT_TRUST=1

# if it's an ssh session export GPG_TTY
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
	GPG_TTY=$(tty)
	export GPG_TTY
fi

# set xdg data dirs for dmenu to source
export XDG_DATA_DIRS=/usr/share/
