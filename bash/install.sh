#!/bin/bash
#
# TODO: write script description
#

set -o errexit  # exit on error
set -o nounset  # no unset variables
set -o pipefail # pipelines cannot hide errors

function clone_dotfiles() {
  local INSTALL_PATH="${HOME}/.dotfiles"
  (cd "${HOME}" || return)

  if [[ ! -f "${HOME}/.ssh/id_rsa" ]]; then
    echo "There was no SSH key found. Not much will get done."
    exit 1
  fi

  git clone --quiet git@github.com:iods/dotfiles.git "${INSTALL_PATH}"
}

function setup_omz() {
  (cd "${HOME}" || return)

  if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh | bash
  else
    echo "Oh My ZSH looks like it already exists. moving on..."
  fi
}

function setup_brew() {
  (cd "${HOME}" || return)

  if test ! "$(which brew)"; then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
  else
    echo "Homebrew looks like it already exists. moving on..."
  fi
}

function create_symlinks() {
  local DOTFILES="${HOME}/.dotfiles"

  (ln -sf "${DOTFILES}/.bash_profile" "${HOME}/.bash_profile")
  (ln -sf "${DOTFILES}/.zshenv" "${HOME}/.zshenv")
  (ln -sf "${DOTFILES}/.zshrc" "${HOME}/.zshrc")
}

function main() {
  clone_dotfiles
  setup_omz
  setup_brew
  create_symlinks
  touch "${HOME}/.hushlogin"
}

main "$@"



==============
#!/bin/bash
cd "$(dirname "$0")"
git pull
function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "sync.sh" --exclude "README.md" -av . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
source ~/.bash_profile




set -e

# Exporting the specific shell we want to work with:

SHELL='/bin/bash'
export SHELL

# Standard dotbot pre-configuration:

readonly DOTBOT_DIR='dotbot'
readonly DOTBOT_BIN='bin/dotbot'
readonly BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

readonly ARGS="$@"

cd "$BASEDIR"
git submodule sync --quiet --recursive
git submodule update --init --recursive

# Linking dotfiles:

run_dotbot () {
  local config
  config="$1"

  "$BASEDIR/$DOTBOT_DIR/$DOTBOT_BIN" \
    -d "$BASEDIR" \
    --plugin-dir dotbot-brewfile \
    --plugin-dir dotbot-pip \
    -c "$config" $ARGS
}

run_dotbot 'steps/terminal.yml' || true
if [ "$CODESPACES" = true ]; then
  run_dotbot 'steps/codespaces.yml' || true
else
  run_dotbot 'steps/dependencies.yml' || true
fi
run_dotbot 'steps/vscode.yml' || true

