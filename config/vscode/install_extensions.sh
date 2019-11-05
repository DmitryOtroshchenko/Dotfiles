#!/usr/bin/env bash

set -e

ext_list="$(git rev-parse --git-dir)/../config/vscode/extensions.txt"
while read ext; do
    echo "Installing $ext ..."
    code --install-extension $ext
done < $ext_list
