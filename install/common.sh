
HOME=$(echo ~)
LOCAL_INSTALL_ROOT="$HOME/local"
mkdir -p "$LOCAL_INSTALL_ROOT"
INSTALL_TMP=$(mktemp -d --tmpdir=$HOME)
function cleanup {
    rm -rf $INSTALL_TMP
}
trap cleanup EXIT

cd "$INSTALL_TMP"
