#!/usr/bin/env bash
# Install cPython interpreter from source
# usage: install_python.sh <version>

set -x
set -e

VERSION=$1

mkdir -p /usr/src/python-$VERSION
cd /usr/src/python-$VERSION


# Install prerequisite libraries

DEPENDENCIES="
    dpkg-dev
    make
    libreadline6-dev
    libsqlite3-dev
    libxslt1-dev
    libxml2-dev
    zlib1g-dev
    libbz2-dev
    libssl-dev
"
command -v apt-get && sudo apt-get install $DEPENDENCIES


# Get Python sources

PYTHON_URL="http://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz"

FILENAME=$(basename $PYTHON_URL)
if [ ! -f $FILENAME ]
then
    wget --quiet $PYTHON_URL
fi

DIRNAME=${FILENAME%.tgz}
if [ ! -d $DIRNAME ]
then
    tar xzf $FILENAME
fi


# Compile and install Python interpreter

cd "$DIRNAME"

[ -d '/System' ] && PREFIX='/System' || PREFIX='/opt'
TARGETDIR="$PREFIX/$(echo $DIRNAME | tr '[A-Z]' '[a-z]')"

export LDFLAGS="-L/usr/lib/$(dpkg-architecture -qDEB_HOST_MULTIARCH)"

./configure --prefix="$TARGETDIR"
make -j4
sudo make install

cd ..

PYTHON=$TARGETDIR/bin/python${VERSION::3}


# Install pip package installer

PIP_URL="https://github.com/pypa/pip/raw/master/contrib/get-pip.py"
wget --no-check-certificate --no-clobber --quiet $PIP_URL
sudo $PYTHON $(basename $PIP_URL)

sudo chmod o+r $TARGETDIR/lib/python${VERSION::3}/site-packages/pip-*/top_level.txt
sudo chmod o+r $TARGETDIR/lib/python${VERSION::3}/site-packages/pip-*/entry_points.txt

PIP="$TARGETDIR/bin/pip"


# Install virtualenv

sudo $PIP install virtualenv


# Install system-wide setuptools and pip

PYTHON="/usr/bin/python"
sudo $PYTHON $(basename $PIP_URL)

# Install system-wide virtualenvwrapper

sudo apt-get install --reinstall virtualenvwrapper -y
