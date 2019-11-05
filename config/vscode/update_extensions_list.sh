#!/usr/bin/env bash

set -e

ext_list="$(git rev-parse --git-dir)/../config/vscode/extensions.txt"
[ -e $ext_list ] && rm -f $ext_list
code --list-extensions > $ext_list
