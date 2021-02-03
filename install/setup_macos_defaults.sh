#!/usr/bin/env bash

# Force R to use UTF-8.
defaults write org.R-project.R force.LANG en_US.UTF-8

# Setup key repeat.
defaults write -g InitialKeyRepeat -int 30
defaults write -g KeyRepeat -int 2
