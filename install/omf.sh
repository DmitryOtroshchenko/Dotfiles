#!/usr/bin/env bash
which fish > /dev/null
if [ $? -eq 0 ]; then
    fish -c "omf -v; or curl -L https://get.oh-my.fish | fish"
else
    echo "fish not installed, cannot install omf."
fi
