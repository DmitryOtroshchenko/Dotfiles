#!/usr/bin/env bash

[[ "$OSTYPE" =~ ^darwin ]] || { echo 'THIS IS NOT MACOSoneoneone' && exit 1; }

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
confirm 'Install kbd layouts?' && ./install/install_layouts.sh

# Dotfiles + dotbot. Install before casks so that all configs were already in place.
which dotbot > /dev/null || { confirm 'Install dotbot?' && \
    sudo /usr/bin/easy_install pip && sudo /usr/local/bin/pip install dotbot; }

confirm 'Link common dotfiles?' && dotbot -c dotbot.yaml
confirm 'Link Mac-specific dotfiles?' && dotbot -c dotbot-macos.yaml

# Homebrew
which brew > /dev/null || { confirm 'Install homebrew?' && \
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; }
# Simple formulae can depend on casks and can not install cask dependencies automatically -> install casks first.

install_casks() {
    while read cask; do
        echo "Installing $cask ..."
        brew cask install $cask
    done <install/brew_casks.txt
}
confirm 'Install casks?' && install_casks && echo 'Now go activate all those apps...' \
    && cat install/brew_casks.txt && open /Applications && confirm 'Done?'

install_formulae() {
    while read form; do
        echo "Installing $form ..."
        brew install $form
    done <install/brew_formulae.txt
}
confirm 'Install formulae?' && install_formulae

# Download creds and access tokens from lastpass.
confirm 'Bootstrap secrets from lastpass?' && {
    lpass login dmitry.otroshchenko@gmail.com && lpass show -F dotfiles-private --notes > ~/Dotfiles/config/fish/source/00.credentials.fish; }

# Misc
tldr --update

echo 'All set!'
