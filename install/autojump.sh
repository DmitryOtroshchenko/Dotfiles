#!/usr/bin/env bash

autojump --version &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installing autojump ..."
    export GITHUB_REPO='https://github.com/wting/autojump'
    git clone --depth 1 $GITHUB_REPO ~/autojump
    cd ~/autojump
    ./install.py
    rm -rf ~/autojump
else
    echo $(autojump --version 2>&1) "already installed."
fi
