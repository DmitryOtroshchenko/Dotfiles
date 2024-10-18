#!/usr/bin/env bash

# Force R to use UTF-8.
defaults write org.R-project.R force.LANG en_US.UTF-8

# Setup key repeat.
defaults write -g InitialKeyRepeat -int 30
defaults write -g KeyRepeat -int 2

# Hide Dock. 
# https://apple.stackexchange.com/questions/59556/is-there-a-way-to-completely-disable-dock
defaults write com.apple.dock autohide -bool true && killall Dock
defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock

# Restore Dock
# defaults write com.apple.dock autohide -bool false && killall Dock
# defaults delete com.apple.dock autohide-delay && killall Dock
# defaults write com.apple.dock no-bouncing -bool FALSE && killall Dock