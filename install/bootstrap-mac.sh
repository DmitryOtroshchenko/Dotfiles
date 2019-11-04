#!/usr/bin/env bash

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

# Homebrew
confirm 'Install homebrew?' && \
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
confirm 'Install formulae?' && \
    cat install/brew_formulae.txt | xargs brew install
confirm 'Install casks?' && \
    cat install/brew_casks.txt | xargs brew cask install

# Dotfiles + dotbot
confirm 'Install dotbot?' && \
    sudo easy_install pip && sudo pip install dotbot

confirm 'Link common dotfiles?' && dotbot -c dotbot.yaml
[[ "$OSTYPE" =~ ^darwin ]] && confirm 'Link Mac-specific dotfiles?' && \
    dotbot -c dotbot-macos.yaml

# Misc
tldr --update
