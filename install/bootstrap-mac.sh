#!/usr/bin/env bash

[[ "$OSTYPE" =~ ^darwin ]] || { echo 'THIS IS NOT MACOSoneoneone' && exit 1; }

dotroot="$(git rev-parse --show-toplevel)"

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
confirm 'Install brew formulae?' && brew bundle --file="$dotroot/Brewfile"

# Download creds and access tokens from lastpass.
confirm 'Bootstrap secrets from lastpass?' && {
    lpass login dmitry.otroshchenko@gmail.com && lpass show -F dotfiles-private --notes > ~/Dotfiles/config/fish/source/00.credentials.fish; }

# Misc
tldr --update

echo 'All set!'
