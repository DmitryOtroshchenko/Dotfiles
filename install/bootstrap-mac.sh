#!/usr/bin/env bash

cd ~

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sudo easy_install pip
sudo pip install dotbot
git clone https://github.com/DmitryOtroshchenko/Dotfiles.git
cd Dotfiles

brew install coreutils fish ripgrep tree fd exa
brew cask install karabiner-elements kitty visual-studio-code vivaldi

brew install tealdeer
tldr --update