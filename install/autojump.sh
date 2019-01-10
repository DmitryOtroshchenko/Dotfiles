#!/usr/bin/env bash

autojump --version &> /dev/null
if [ $? -ne 0 ]; then
    echo 'Installing autojump ...'
    source $(dirname $0)/common.sh
    cd $LOCAL_INSTALL_ROOT
    export GITHUB_REPO='https://github.com/wting/autojump'
    git clone --depth 1 $GITHUB_REPO .autojump
    cd .autojump
    ./install.py --prefix=$LOCAL_INSTALL_ROOT
else
    echo $(autojump --version 2>&1) 'already installed.'
fi
