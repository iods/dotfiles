# run every zsh login

# start hugo server for journal
# Moved to system.d
# if [ -f $HOME/.functions ]; then
# 	if ! pgrep -x "hugo" >/dev/null; then
# 		hugo-start
# 	fi
# fi

Initial Setup 🎉


1. Getting Started
  a. Introduction
  b. Background
  c. References
2. Notes
3. Description
  a. Abstract
  b. Perspectives
  c. Environments
  d. contstrains
  e. assumptions/depend
Requiremens
one
Data Requirements
   organization
   reporting and analytics
   migration strategies


   # {{{ Recompile ZSH files

   # <https://github.com/htr3n/zsh-config/blob/master/zlogin>

   # Execute code in the background to not affect the current session
   (
       autoload -U zrecompile

       # Compile zcompdump, if modified, to increase startup speed
       zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
       if [[ -s "${zcompdump}" && (! -s "${zcompdump}.zwc" || "${zcompdump}" -nt "${zcompdump}.zwc") ]]; then
           zrecompile -pq "${zcompdump}"
       fi

       # Recompile zsh files
       zrecompile -pq ${ZDOTDIR:-${HOME}}/.zlogin
       zrecompile -pq ${ZDOTDIR:-${HOME}}/.zlogout
       zrecompile -pq ${ZDOTDIR:-${HOME}}/.zprofile
       zrecompile -pq ${ZDOTDIR:-${HOME}}/.zshenv
       zrecompile -pq ${ZDOTDIR:-${HOME}}/.zshrc

       for f in "${ZDOTDIR:-$HOME}/.sh/inc"/*.sh; do
           zrecompile -pq "${f}"
       done

       for f in "${ZDOTDIR:-$HOME}/.zsh/inc"/*.zsh; do
           zrecompile -pq "${f}"
       done
   ) &!

   # }}}

   # vim:filetype=zsh:tabstop=2:shiftwidth=2:fdm=marker:
