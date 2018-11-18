#!/usr/bin/env bash
which fish > /dev/null
if [ $? -eq 0 ]; then
    export GITHUB_REPO='https://raw.githubusercontent.com/shannonmoeller/up/master/up.fish'
    export DOWNLOAD_PATH=$(mktemp)

    curl -o $DOWNLOAD_PATH $GITHUB_REPO
    fish -c "source $DOWNLOAD_PATH"
else
    echo "fish not installed, cannot install up.fish"
fi
