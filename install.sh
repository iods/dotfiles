#!/bin/bash
#
# TODO: write script description
#
# 1. clone it locally
# 2. copy the files or ln -s?
# 3.

set -o errexit
set -o nounset
set -o pipefail

function clone_dotfiles() {
  local INSTALL_PATH="${HOME}/.dotfiles"
  # (cd "${HOME}" || return)

  if [[ ! -f "${HOME}/.ssh/id_rsa" ]]; then
    echo "There was no SSH key found. Not much will get done."
    exit 1
  fi

  git clone git@github.com:iods/dotfiles.git "${INSTALL_PATH}"
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

  (ln -s "${DOTFILES}/.bash_profile" "${HOME}/.bash_profile")
  (ln -s "${DOTFILES}/.zshrc" "${HOME}/.zshrc")
}

function main() {
  clone_dotfiles
  setup_omz
  setup_brew
  create_symlinks
}

main "$@"