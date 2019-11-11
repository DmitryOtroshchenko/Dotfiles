fish_vi_key_bindings

# set config_debug 1

set dotfiles_root (echo ~)'/Dotfiles/'

set -gx PATH "$HOME/local/bin" $PATH

function debug_echo
    set -q config_debug; and echo $argv
end

#
# Basic exports.
#

set -x SHELL (which fish)
set -x TERM 'xterm-kitty'

set -x LANG 'en_US.UTF-8'
set -x LC_ALL 'en_US.UTF-8'

set -x EDITOR 'code'
set -x VISUAL 'code'
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
# Source modules.
#

set fish_config_root (echo ~)'/.config/fish/'
source $fish_config_root'/source/macos.fish'
set to_source (ls -1 $fish_config_root'/source/' | rg '^[^_].+.fish')
for fn in $to_source
    debug_echo 'Sourcing '$fn
    source $fish_config_root'/source/'$fn
end

#
# Standard GNU tools.
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

alias ls='ls --group-directories-first -h --color --sort=extension --classify --hide="*.pyc" --hide="__pycache__"'

alias md='mkdir -p'
alias rd='rmdir'
alias mv='mv -i'
alias cp='cp -i'
alias cb='cd -'

set -x RIPGREP_CONFIG_PATH $dotfiles_root'/config/ripgreprc'

#
# Git goodies.
#

abbr -e gcm
abbr -a gcm 'git commit -m'
abbr -a ga 'git add'
abbr -a gia 'git add -p'
abbr -a st 'git status'

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
# Autojump
#

set autojump_setup_fish '/usr/local/share/autojump/autojump.fish'
test -f $autojump_setup_fish; and source $autojump_setup_fish

#
# Other
#

alias ns='exa -F --group-directories-first'
alias nt='exa --tree --group-directories-first'
alias na='exa -lF --group-directories-first'

set -gx RANGER_LOAD_DEFAULT_RC FALSE

# Ranger-like gotos
alias gh='cd ~'
alias gw='cd ~/workbench'
alias gd='cd ~/Dotfiles'
