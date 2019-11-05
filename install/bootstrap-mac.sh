#!/usr/bin/env bash

[[ "$OSTYPE" =~ ^darwin ]] || exit 1

confirm() {
    # Call with a prompt string or use a default.
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

cd ~/Dotfiles

./install/setup_macos_defaults.sh
confirm 'Install kbd layouts?' &&
    ./install/install_layouts.sh

# Homebrew
confirm 'Install homebrew?' && \
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Simple formulae can depend on casks and can not install cask dependencies automatically -> install casks first.
confirm 'Install casks?' && \
    cat install/brew_casks.txt | xargs brew cask install
confirm 'Install formulae?' && \
    cat install/brew_formulae.txt | xargs brew install

# Dotfiles + dotbot
confirm 'Install dotbot?' && \
    sudo /usr/bin/easy_install pip && sudo /usr/local/bin/pip install dotbot

confirm 'Link common dotfiles?' && dotbot -c dotbot.yaml
[[ "$OSTYPE" =~ ^darwin ]] && confirm 'Link Mac-specific dotfiles?' && \
    dotbot -c dotbot-macos.yaml

# Misc
tldr --update
