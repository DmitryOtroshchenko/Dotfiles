fish_vi_key_bindings

#
# External scripts that require sourcing.
#

# Use omf autojump?
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

#
# Basic exports.
#

set -x SHELL (which fish)
set -x TERM 'xterm-256color'

set -x LANG 'en_US.UTF-8'
set -x LC_ALL 'en_US.UTF-8'

set -x EDITOR 'vim'
set -x VISUAL 'vim'
set -x PAGER 'less'

#
# Basic helper functions.
#

function file_ext
    if [ (count $argv) = 1 ]
        echo (echo $argv[1] | sed 's/^.*\.//')
    else
        return 1
    end
end

function file_basename
    if [ (count $argv) = 1 ]
        echo (echo $argv[1] | sed 's/\.[^.]*$//')
    else
        return 1
    end
end

#
# Standard GNU tools.
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

alias ls="ls --group-directories-first -h --color --sort=extension --classify --ignore=\"*.pyc\""

alias md='mkdir -p'
alias rd='rmdir'
alias mv='mv -i'
alias cp='cp -i'

# TODO:
set -x RIPGREP_CONFIG_PATH '/Users/d.otroshchenko/Dotfiles/config/ripgreprc'

#
# Git goodies.
#

abbr -e gcm
abbr -a gcm 'git commit -m'
abbr -a gia 'git add -p'

function st
    git status
end

#
# Search for files by name using ripgrep.
#

function rgfs --wraps rg
    rg --files --glob $argv
end

function rgfi --wraps rg
    rg --files --iglob $argv
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
# SSH
#

function ssh-ci --wraps ssh-copy-id
    ssh-copy-id -i ~/.ssh/id_rsa.pub $argv
end

function ssh-aliases
    sed -rn 's/^\s*Host\s+(.*)\s*/\1/ip' ~/.ssh/config | grep -v '\*'
end

#
# R
#

# Fixes R locale error.
# defaults write org.R-project.R force.LANG en_US.UTF-8
