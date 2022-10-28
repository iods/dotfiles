#   ____  ____  ____  ____
#  ||i  |||o  |||d  |||s  |
#  ||___|||___|||___|||___|
#  |/___\|/___\|/_ _\|/___\
#
# Version 0.1.0 [2020-12-27]
# http://github.com/iods/dotfiles
# Copyright (c) 2020, Rye Miller

default:
	@echo "yeah"
	@echo "Cowardly refusing to run on $(shell uname). Use platform specific targets."


# my magic photobooth symlink -> dropbox. I love it.
# first move Photo Booth folder out of Pictures
# then start Photo Booth. It'll ask where to put the library.
# put it in Dropbox/public

# now you can record photobooth videos quickly and they upload to dropbox DURING RECORDING
# then you grab public URL and send off your video message in a heartbeat.




SHELL = /bin/bash
OS := $(shell bin/is-supported bin/is-macos macos linux)
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
HOMEBREW_PREFIX := $(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local)
PATH := $(HOMEBREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(PATH)
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA=Y

.PHONY: test

all: $(OS)

macos: sudo core-macos packages link

linux: core-linux link

core-macos: brew bash git npm ruby rust

core-linux:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: core-linux
	is-executable stow || apt-get -y install stow

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

packages: brew-packages cask-apps node-packages rust-packages

link: stow-$(OS)
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(HOME) runcom
	stow -t $(XDG_CONFIG_HOME) config

unlink: stow-$(OS)
	stow --delete -t $(HOME) runcom
	stow --delete -t $(XDG_CONFIG_HOME) config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

bash: BASH_BIN=$(HOMEBREW_PREFIX)/bin/bash
bash: BREW_BIN=$(HOMEBREW_PREFIX)/bin/brew
bash: SHELLS=/private/etc/shells
bash: brew
ifdef GITHUB_ACTION
	if ! grep -q $(BASH_BIN) $(SHELLS); then \
		$(BREW_BIN) install bash bash-completion@2 pcre && \
		sudo append $(BASH_BIN) $(SHELLS) && \
		sudo chsh -s $(BASH_BIN); \
	fi
else
	if ! grep -q $(BASH_BIN) $(SHELLS); then \
		$(BREW_BIN) install bash bash-completion@2 pcre && \
		sudo append $(BASH_BIN) $(SHELLS) && \
		chsh -s $(BASH_BIN); \
	fi
endif

git: brew
	brew install git git-extras

npm: brew-packages
	fnm install --lts

ruby: brew
	brew install ruby

rust: brew
	brew install rust

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true
	defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done
	xattr -d -r com.apple.quarantine ~/Library/QuickLook

node-packages: npm
	eval $$(fnm env); npm install -g $(shell cat install/npmfile)

rust-packages: rust
	cargo install $(shell cat install/Rustfile)

test:
	eval $$(fnm env); bats test






default:
	@echo "Cowardly refusing to run on $(shell uname). Use platform specific targets."

init: brew-install brew-bundle link-dotfiles link-karabiner macos
	osascript -e 'tell app "loginwindow" to «event aevtrrst»'

init-post-reboot: asdf link-sublime link-vscode restore-preferences disable-restore-apps-on-login

brew-install:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

brew-bundle:
	brew update
	brew bundle

asdf:
	asdf plugin-add golang
	asdf plugin-add ruby
	asdf plugin-add nodejs
	asdf plugin-add erlang
	asdf plugin-add elixir

macos:
	sh .macos

link-dotfiles:
	mkdir -p $$HOME/.local
	./link-dotfiles.sh

link-karabiner:
	# don't link entire .config directory because it contains secrets sometimes
	mkdir -p $$HOME/.config
	ln -s $$PWD/karabiner $$HOME/.config/karabiner

link-sublime:
	git clone https://github.com/nonrational/sublime3 $$HOME/.sublime3
	rm -rf $$HOME/Library/Application\ Support/Sublime\ Text\ 3
	ln -s $$HOME/.sublime3 $$HOME/Library/Application\ Support/Sublime\ Text\ 3

link-vscode:
	ln -sf $$PWD/etc/vscode.keybindings.json $$HOME/Library/Application\ Support/Code/User/keybindings.json
	ln -sf $$PWD/etc/vscode.settings.json $$HOME/Library/Application\ Support/Code/User/settings.json

backup-preferences:
	cp $$HOME/Library/Preferences/com.googlecode.iterm2.plist $$PWD/etc/com.googlecode.iterm2.plist
	cp $$HOME/Library/Containers/com.if.Amphetamine/Data/Library/Preferences/com.if.Amphetamine.plist $$PWD/etc/com.if.Amphetamine.plist
	code --list-extensions > $$PWD/etc/vscode--list-extensions.txt

restore-preferences:
	cp $$PWD/etc/com.googlecode.iterm2.plist $$HOME/Library/Preferences/com.googlecode.iterm2.plist
	cp $$PWD/etc/com.if.Amphetamine.plist $$HOME/Library/Containers/com.if.Amphetamine/Data/Library/Preferences/com.if.Amphetamine.plist
	cat $$PWD/etc/vscode--list-extensions.txt | xargs -n 1 code --install-extension

disable-restore-apps-on-login:
	# See https://apple.stackexchange.com/a/322787
	# clear the file if it isn't empty
	find ~/Library/Preferences/ByHost/ -name 'com.apple.loginwindow*' ! -size 0 -exec tee {} \; < /dev/null
	# set the user immutable flag
	find ~/Library/Preferences/ByHost/ -name 'com.apple.loginwindow*' -exec chflags uimmutable {} \;


.PHONY: init init-post-reboot brew-install brew-bundle asdf link-dotfiles link-karabiner macos sublime backup-preferences restore-preferences disable-restore-apps-on-login
