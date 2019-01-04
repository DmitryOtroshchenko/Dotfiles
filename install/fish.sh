#!/usr/bin/env bash

# https://gist.github.com/masih/10277869

# Script for installing Fish Shell on systems without root access.
# Fish Shell will be installed in $HOME/local/bin.
# It's assumed that wget and a C/C++ compiler are installed.

set -e

FISH_VERSION=$1
FISH_VERSION=${FISH_VERSION:-2.7.1}
echo "Installing fish $FISH_VERSION ..."

source $(dirname $0)/common.sh

wget https://github.com/fish-shell/fish-shell/releases/download/$FISH_VERSION/fish-$FISH_VERSION.tar.gz
tar xvzf fish-${FISH_VERSION}.tar.gz
cd fish-${FISH_VERSION}

./configure --prefix=$HOME/local --disable-shared
make
make install
