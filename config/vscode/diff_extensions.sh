#!/usr/bin/env bash

set -e

current_ext_list=$(mktemp)
code --list-extensions > $current_ext_list

git_ext_list="$(git rev-parse --git-dir)/../config/vscode/extensions.txt"
colordiff -y $git_ext_list $current_ext_list
