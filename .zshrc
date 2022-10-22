# Path to your dotfiles.
export DOTS="$HOME/.dotfiles"


# init colors and word characters are alphanumeric only
autoload -U colors && colors
autoload -U select-word-style && select-word-style bash

#
# ZSH Options
# http://zsh.sourceforge.net/Doc/Release/Options.html
#
setopt AUTO_CD                  # if a command isn't valid, but is a directory, cd to that dir
setopt AUTO_PUSHD               # make cd push the old directory onto the directory stack
setopt PUSHD_IGNORE_DUPS        # don’t push multiple copies of the same directory onto the directory stack
setopt PUSHD_MINUS              # exchanges the meanings of ‘+’ and ‘-’ when specifying a directory in the stack

setopt ALWAYS_TO_END            # move cursor to the end of a completed word
setopt AUTO_LIST                # automatically list choices on ambiguous completion
setopt AUTO_MENU                # show completion menu on a successive tab press
setopt AUTO_PARAM_SLASH         # if completed parameter is a directory, add a trailing slash
setopt COMPLETE_IN_WORD         # complete from both ends of a word
unsetopt MENU_COMPLETE          # don't auto-select the first completion entry

setopt EXTENDED_GLOB            # use more awesome globbing features
setopt GLOB_DOTS                # include dotfiles when globbing

HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=2000
setopt APPEND_HISTORY           # appends history to the existing file (.zsh_history)
setopt BANG_HISTORY             # treat the "!" character special during expansion
setopt EXTENDED_HISTORY         # write history in the ":start:elapsed;command" format
unsetopt HIST_BEEP              # don't beep when attempting to access a missing history entry
setopt HIST_EXPIRE_DUPS_FIRST   # expire dup entries first when trimming history
setopt HIST_IGNORE_DUPS         # don't record any entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS     # delete old recorded entry if new entry is duplicate
setopt HIST_IGNORE_SPACE        # don't record an entry starting with a space
setopt HIST_FIND_NO_DUPS        # do not display a line previously found
setopt HIST_NO_STORE            # don't store history commands
setopt HIST_REDUCE_BLANKS       # remove blank lines before recording entries
setopt HIST_SAVE_NO_DUPS        # don't write duplicate entries in the history
setopt HIST_SHARE_HISTORY       # share history across multiple sessions
setopt HIST_VERIFY              # don't immediately execute upon history expansion
setopt INC_APPEND_HISTORY       # write to the history file immediately, not when the shell exits
unsetopt SHARE_HISTORY          # don't share history between all sessions

unsetopt CLOBBER                # must use >| to truncate existing files
unsetopt CORRECT                # don't try to correct the spelling of commands
unsetopt CORRECT_ALL            # don't try to correct the spelling of all arguments in a line
unsetopt FLOW_CONTROL           # disable start/stop characters in shell editor
setopt INTERACTIVE COMMENTS     # enable comments in interactive shell
unsetopt MAIL_WARNING           # don't print a warning message if a mail file has been accessed
setopt PATH_DIRS                # perform path search even on command names with slashes
setopt RC_QUOTES                # allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
unsetopt RM_STAR_SILENT         # ask for confirmation for `rm *' or `rm path/*'

setopt AUTO_RESUME              # attempt to resume existing job before creating a new process
unsetopt BG_NICE                # don't run all background jobs at a lower priority
unsetopt CHECK_JOBS             # don't report on jobs when shell exit
unsetopt HUP                    # don't kill jobs on shell exit
setopt LONG_LIST_JOBS           # list jobs in the long format by default
setopt NOTIFY                   # report status of background jobs immediately

setopt PROMPT_SUBST             # expand parameters in prompt variables

unsetopt BEEP                   # be quiet :)
setopt COMBINING_CHARACTERS     # combine zero-length punctuation characters (accents) with the base character
setopt EMACS                    # use emacs keybindings in the shell


# export PATH=$HOME/bin:/usr/local/bin:$PATH


export ZSH="$HOME/.oh-my-zsh"

. "${DOTS}/bash/aliases.sh"  # include the aliases

ZSH_THEME="robbyrussell"
ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 13
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export PATH=/opt/homebrew/bin:$PATH
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion





export PATH=/usr/local/bin:$PATH
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"


export PATH="/Users/rmiller/Developer/Corra/cloud-tools/bin:$PATH"


# BEGIN SNIPPET: Magento Cloud CLI configuration
HOME=${HOME:-'/Users/rmiller'}
export PATH="$HOME/"'.magento-cloud/bin':"$PATH"
if [ -f "$HOME/"'.magento-cloud/shell-config.rc' ]; then . "$HOME/"'.magento-cloud/shell-config.rc'; fi # END SNIPPET
#export PATH="$HOME/.cloud-tools/bin:$PATH"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"