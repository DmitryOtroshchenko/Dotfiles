#!/usr/bin/env bash

fzf --version > /dev/null
if [ $? -ne 0 ]; then
    echo 'Installing fzf ...'
    source $(dirname $0)/common.sh
    cd $LOCAL_INSTALL_ROOT
    GITHUB_REPO='https://github.com/junegunn/fzf.git'
    git clone --depth 1 $GITHUB_REPO $LOCAL_INSTALL_ROOT/.fzf
    $LOCAL_INSTALL_ROOT/.fzf/install --key-bindings --completion --update-rc
else
    echo "fzf $(fzf --version) already installed."
fi
