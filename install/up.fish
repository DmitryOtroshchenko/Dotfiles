#!/usr/bin/env fish

type -q up
if [ $status != 0 ]
    echo "Installing up.fish ..."
    set HOME (echo ~)
    set DOWNLOAD_PATH (mktemp --tmpdir=$HOME)
    set GITHUB_REPO 'https://raw.githubusercontent.com/shannonmoeller/up/master/up.fish'
    curl -o $DOWNLOAD_PATH $GITHUB_REPO
    type -q up ; or source $DOWNLOAD_PATH
    rm -f $DOWNLOAD_PATH
else
    echo "up.fish already installed."
end
