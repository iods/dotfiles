#!/bin/bash
#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# Load all my dotfile needs, please.
# .bash_profile is loaded in login shells.
#
# .bash_profile is loaded in login shells (also see .bashrc).

case $~ in
  *i*) ;;
    *) return
    ;;
esac



[[ -s ~/.profile ]] && source ~/.profile
[[ -s ~/.bashrc ]] && source ~/.bashrc
# if not running interactively, don't do anything
[ -z "${PS1}" ] && return

[[ -s "$HOME/.profile" ]] && source "${HOME}/.profile"


# colorize grep
export GREP_OPTIONS='--color=auto'

# colorize ls
eval "$(dircolors -b "$HOME/.dotfiles"/system/.dir_colors)"


if [ -f "$HOME/.bashrc" ]; then
  # shellcheck source=/dev/null
  # source "${HOME}/.bashrc"
fi

if [ -f "$HOME/.hostname" ]; then
  LOCALHOSTNAME=`cat $HOME/.hostname`
else
  LOCALHOSTNAME=$HOSTNAME
fi



if [[ $- == *i* ]]; then
  # shellcheck source=.bashrc
  . "$HOME/.bashrc"
fi

# add local bin path
PATH=$HOME/.bin:$PATH
PATH=/usr/local/bin:$PATH
PATH=/usr/local/sbin:$PATH
[ -d /usr/local/mysql/bin ] && PATH=/usr/local/mysql/bin:$PATH
[ -d /usr/local/share/npm/bin ] && PATH=/usr/local/share/npm/bin:$PATH



# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh



# check if git is installed on config load
PS1_GIT_BIN=$(which git 2>/dev/null)


# set new b/w prompt (will be overwritten in 'prompt_command' later for color prompt)
PS1='\u@${LOCAL_HOSTNAME}:\w\$ '



# osx sources this on every new Terminal.app tab/window but NOT on new bash's
# so, screen will *not* source this on new screen creation (ctrl+a,c)

export BASH_SILENCE_DEPRECATION_WARNING=1

source_if_exists() {
  [[ -s "$1" ]] && source "$1"
}

# homebrew config
export PATH="./bin:$HOME/bin:$HOME/.local/bin:/usr/local/sbin:$PATH"
source_if_exists "/usr/local/opt/asdf/libexec/asdf.sh"
source_if_exists "/usr/local/etc/profile.d/autojump.sh"
source_if_exists "/usr/local/etc/bash_completion"

source_if_exists "$HOME/.bashrc"




#
# Python
# TODO add to .profile then include
if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
	export PROJECT_HOMES=~/work/
	export WORKON_HOMSE=~/work/.venv/
	export VIRTUAL_ENV_DISABLE_PROMPT=1
	source /usr/local/bin/virtualenvwrapper.sh
fi


# clean up by unset all the used variables

# Source the dotfiles (order matters)

for DOTFILE in "$DOTFILES_DIR"/system/.{function,function_*,path,env,exports,alias,fnm,grep,prompt,completion,fix}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done

if is-macos; then
  for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,function,path}.macos; do
    [ -f "$DOTFILE" ] && . "$DOTFILE"
  done
fi
