#!/usr/bin/env bash

fzf --version > /dev/null
if [ $? -ne 0 ]; then
    echo "Installing fzf ..."
    export GITHUB_REPO='https://github.com/junegunn/fzf.git'
    git clone --depth 1 $GITHUB_REPO ~/.fzf
    ~/.fzf/install
else
    echo "fzf $(fzf --version) already installed."
fi
