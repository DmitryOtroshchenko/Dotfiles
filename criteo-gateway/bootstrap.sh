
cd $(eval echo ~$(whoami))

ARCHIVE_NAME="app.tar.gz"
curl -OL "https://github.com/DmitryOtroshchenko/Dotfiles/raw/master/criteo-gateway/$ARCHIVE_NAME"
tar -xvzf $ARCHIVE_NAME
rm $ARCHIVE_NAME

APPS_ROOT=".app"
if [[ -d $APPS_ROOT ]]; then
    echo "WARNING: $APPS_ROOT already exists, overwriting it."
    rm -rf $APPS_ROOT
fi
mv app $APPS_ROOT

cd $APPS_ROOT
rm -rf "bin"
mkdir -p "bin"
echo "$(pwd)/*/bin/*"
ln -s $(pwd)/*/bin/* $(pwd)/bin/
