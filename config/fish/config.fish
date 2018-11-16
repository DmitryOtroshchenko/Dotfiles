fish_vi_key_bindings

#
# Intresting plugins
#

# Installed: grc, osx, python, colored-man-pages, dpaste, epwd
#   fonts, tab
# To test: brew, envious

#
# External scripts that require sourcing.
#

# Use omf autojump?
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# Also using https://github.com/shannonmoeller/up

#
# Basic exports.
#

set -x TERM 'xterm-256color'

set -x LANG 'en_US.UTF-8'
set -x LC_ALL 'en_US.UTF-8'

set -x EDITOR 'vim'
set -x VISUAL 'vim'
set -x PAGER 'less'

#
# Standard GNU tools.
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

alias ls="ls --group-directories-first -h --color --sort=extension --classify --ignore=\"*.pyc\""

# TODO:
set -x RIPGREP_CONFIG_PATH '/Users/d.otroshchenko/Dotfiles/config/ripgreprc'

#
# Git goodies.
#

function gc --wraps git
    git commit $argv;
end

function gcm --wraps git
    git commit -m $argv;
end

function gia --wraps git
    git add $argv;
end

function giA --wraps git
    git add -p $argv;
end

function st
    git status
end

function g --wraps git
    git $argv;
end

#
# Search for files by name using ripgrep.
#

function rgfs --wraps rg
    rg --files --glob $argv;
end

function rgfi --wraps rg
    rg --files --iglob $argv;
end

function rgf --wraps rg
    rgfi $argv
end

#
# Python
#

function pt --wraps pytest
    pytest -s --pdb --pdbcls=IPython.terminal.debugger:Pdb $argv
end

function pl --wraps pylint
    pylint -r n $argv
end

# Anaconda
source ~/anaconda3/etc/fish/conf.d/conda.fish
conda activate
conda activate sandbox

#
# Platform specific
#

source ~/.config/fish/functions/macos_specific.fish

#
# Other.
#

function fkill -a signal
    set -q signal[1]; or set signal '-9'
    set pids_to_kill (ps -efww | fzf -m -i +x -e --header-lines=1 | awk '{print $2}')
    if set -q pids_to_kill[1]
        kill $signal $pids_to_kill
    else
        echo 'Kill aborted.'
    end
end

#
# R
#

# Fixes R locale error.
# defaults write org.R-project.R force.LANG en_US.UTF-8

#
# TODO
#

# function cd {
#     builtin cd "$@" && ls
# }
