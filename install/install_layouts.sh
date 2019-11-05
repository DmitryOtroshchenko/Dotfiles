#!/usr/bin/env bash

dotfiles_root=$(git rev-parse --show-toplevel)
sudo cp -R "$dotfiles_root/config/keyboard_layouts/." '/Library/Keyboard Layouts/'
