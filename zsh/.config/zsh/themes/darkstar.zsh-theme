#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# The Dark Star custom ZSH theme.
#
# Version 000.2.2 [2024-10-31]
# http://github.com/iods/dotfiles
# Copyright (c) 2023-Present, Rye Miller

# Global settings
DS_COLOR_OUT="${DS_COLOR_OUT:-2}"
DS_COLOR_ERR="${DS_COLOR_ERR:-1}"
DS_COLOR_HOST=green
DS_COLOR_PWD=cyan
DS_COLOR_RETURN_STATUS=magenta
DS_COLOR_FALSE=yellow
DS_COLOR_GIT_STATUS_DEFAULT=green
DS_COLOR_GIT_STATUS_STAGED=red
DS_COLOR_GIT_STATUS_UNSTAGED=yellow
DS_COLOR_GIT_PROMPT_SHA=green

DS_ICO_ARROW=$'\u2192'
DS_ICO_CROSS=$'\u263f'
DS_ICO_INFINITY=$'\u221E'
DS_ICO_KNIGHT=$'\u265e'
DS_ICO_NO='$\u2718'
DS_ICO_QUEEN=$'\u265b'
DS_ICO_RIGHT=$'\u25b6'
DS_ICO_SKULL=$'\u2620'
DS_ICO_SNOW=$'\u2744'
DS_ICO_STAR=$'\u2605'
DS_ICO_STAR_LINE=$'\u2606'
DS_ICO_TRI=$'\u2234'
DS_ICO_WARNING=$'\u26a0'
DS_ICO_YES=$'\u2714'

DS_NEWLINE=$'\n'

#⛄ 🖕

# PROMPT='%{$fg_bold[white]%} ${DS_ICO_STAR} %{$fg_bold[green]%} %{$fg[green]%}%c %{$fg_bold[cyan]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

#PROMPT='%{$fg_bold[white]%}${DS_ICO_STAR} $(prompt_host)$(prompt_pwd)%{$reset_color%}'

setopt promptsubst
PROMPT='$(prompt_symbol)$(prompt_pwd)$(git_prompt_info)'
RPROMPT='$(prompt_git_status) ${DS_ICO_STAR_LINE}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}] %{$fg[yellow]%}💀%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}]"
#ZSH_THEME_GIT_PROMPT_SHA_BEFORE=%{%F{$}}
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%} "

prompt_git_status() {
	local msg=""
	local msg_color="%F{$DS_COLOR_GIT_STATUS_DEFAULT}"

	local staged=$(git status --porcelain 2> /dev/null | grep -e "^[MADRCU]")
	local unstaged=$(git status --porcelain 2> /dev/null | grep -e "^[MADRCU? ][MADRCU?]")

	if [[ -n ${staged} ]]; then
		msg_color="%F{DS_COLOR_GIT_STATUS_STAGED}"
	elif [[ -n ${unstaged} ]]; then
		msg_color="%F{DS_COLOR_GIT_STATUS_UNSTAGED}"
	fi

	local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
	if [[ -n $branch ]]; then
		message+="${msg_color}${branch}%f"
	fi

	echo -n "${message}"
}

prompt_host() {
	if [[ -n $SSH_CONNECTION ]]; then
		ds_name="%n@%m"
	elif [[ $LOGNAME != $USER ]]; then
		ds_name="%n"
	fi

	if [[ -n $ds_name ]]; then
		echo "%{$fg[$DS_COLOR_HOST]%}$ds_name%{$reset_color%}:"
	fi
}

prompt_pwd() {
	echo -n "%{$fg[$DS_COLOR_PWD]%}%c%{$reset_color%} "
}

prompt_symbol() {
	echo -n "%{$fg_bold[white]%}$DS_ICO_STAR%f "
}