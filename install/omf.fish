#!/usr/bin/env fish

type -q omf
if [ $status != 0 ]
    echo "Installing omf ..."
    curl -L https://get.oh-my.fish | fish
else
    echo "omf already installed."
end
