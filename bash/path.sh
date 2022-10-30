
# Load system binaries
export PATH="/usr/local/sbin:$PATH"

# Load Composer tools
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Load local binaries
export PATH="$HOME/.local/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"


#!/bin/sh

# go path
export GOPATH="${HOME}/.go"

# update path
export PATH=/usr/local/bin:${PATH}:/sbin:/usr/local/sbin

# add go path
export PATH="/usr/local/go/bin:${GOPATH}/bin:${PATH}"

# add rust path
export PATH="${HOME}/.cargo/bin:${PATH}"

# add bcc tools path
export PATH="/usr/share/bcc/tools:${PATH}"

# add gnubin for mac
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:${PATH}"

# add gnu getopt
export PATH="/usr/local/opt/gnu-getopt/bin:${PATH}"


# http://blog.bitfluent.com/post/27983389/git-utilities-you-cant-live-without
# http://superuser.com/questions/31744/how-to-get-git-completion-bash-to-work-on-mac-os-x

# 17:39:15 henrik@Nyx project_dir master*$

function __git_prompt {
  GIT_PS1_SHOWDIRTYSTATE=1
  [ `git config user.pair` ] && GIT_PS1_PAIR="`git config user.pair`@"
  __git_ps1 " $GIT_PS1_PAIR%s" | sed 's/ \([+*]\{1,\}\)$/\1/'
}

# Only show username@server over SSH.
function __name_and_server {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "`whoami`@`hostname -s` "
  fi
}

bash_prompt() {

  # regular colors
  local K="\[\033[0;30m\]"    # black
  local R="\[\033[0;31m\]"    # red
  local G="\[\033[0;32m\]"    # green
  local Y="\[\033[0;33m\]"    # yellow
  local B="\[\033[0;34m\]"    # blue
  local M="\[\033[0;35m\]"    # magenta
  local C="\[\033[0;36m\]"    # cyan
  local W="\[\033[0;37m\]"    # white

  # emphasized (bolded) colors
  local BK="\[\033[1;30m\]"
  local BR="\[\033[1;31m\]"
  local BG="\[\033[1;32m\]"
  local BY="\[\033[1;33m\]"
  local BB="\[\033[1;34m\]"
  local BM="\[\033[1;35m\]"
  local BC="\[\033[1;36m\]"
  local BW="\[\033[1;37m\]"

  # reset
  local RESET="\[\033[0;37m\]"

  PS1="\t $BY\$(__name_and_server)$Y\W $G\$(__git_prompt)$RESET$ "

}

bash_prompt
unset bash_prompt



# add mysql
export PATH="/opt/homebrew/opt/mysql-client/bin:${PATH}"

# update cdpath
export CDPATH=${CDPATH}:${GOPATH}/src/github.com:${GOPATH}/src/golang.org:${GOPATH}/src

# The next line updates PATH for the Google Cloud SDK.
# shellcheck source=/dev/null
if [ -f "${HOME}/.google-cloud-sdk/path.bash.inc" ]; then . "${HOME}/.google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
# shellcheck source=/dev/null
if [ -f "${HOME}/.google-cloud-sdk/completion.bash.inc" ]; then . "${HOME}/.google-cloud-sdk/completion.bash.inc"; fi

export PATH="${HOME}/.google-cloud-sdk/bin:${PATH}"

# update path for gnu coreutils, make & find on darwin
export PATH=/usr/local/opt/coreutils/libexec/gnubin:${PATH}
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}
export PATH=/usr/local/opt/make/libexec/gnubin:${PATH}
export MANPATH=/usr/local/opt/make/libexec/gnuman:${MANPATH}
export PATH=/usr/local/opt/findutils/libexec/gnubin:${PATH}
export MANPATH=/usr/local/opt/findutils/libexec/gnuman:${MANPATH}

# update path for Chromium depot_tools
export PATH="${PATH}:${HOME}/depot_tools"

# Add bash completion for Chromium depot_tools
# shellcheck source=/dev/null
if [ -f "${HOME}/depot_tools/git_cl_completion.sh" ]; then . "${HOME}/depot_tools/git_cl_completion.sh"; fi

# Homebrew
export PATH="/opt/homebrew/bin:${PATH}"
export PATH="/opt/homebrew/sbin:${PATH}"
export LIBRARY_PATH="/opt/homebrew/lib:${LIBRARY_PATH}"
export LDFLAGS="${LDFLAGS} -L/opt/homebrew/lib"
export CPPFLAGS="${CPPFLAGS} -I/opt/homebrew/include"

# shellcheck source=/dev/null
if [ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]; then . "/opt/homebrew/etc/profile.d/bash_completion.sh"; fi

# OpenSSL
export PATH="/opt/homebrew/opt/openssl/bin:${PATH}"
export LDFLAGS="${LDFLAGS} -L/opt/homebrew/opt/openssl/lib"
export CPPFLAGS="${CPPFLAGS} -I/opt/homebrew/opt/openssl/include"
export OPENSSL_ROOT_DIR="/opt/homebrew/opt/openssl"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl/lib/pkgconfig:${PKG_CONFIG_PATH}"

# MySQL
export MYSQL_INCLUDE_DIR="/opt/homebrew/opt/mysql-client/include/mysql"

# LLVM
export PATH="/opt/homebrew/opt/llvm/bin:${PATH}"

# Boost
export BOOST_INCLUDE_DIR="/opt/homebrew/include"

# CXXFLAGS
CXXFLAGS="${CXXFLAGS} -stdlib=libc++ -Wno-deprecated-declarations -Wno-deprecated -framework CoreFoundation"

# opam configuration
test -r "${HOME}/.opam/opam-init/init.sh" && . "${HOME}/.opam/opam-init/init.sh" > /dev/null 2> /dev/null || true
