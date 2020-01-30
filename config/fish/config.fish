fish_vi_key_bindings

# set config_debug 1

set dotfiles_root (echo ~)'/Dotfiles/'

set -gx PATH "$HOME/.local/bin" $PATH

function debug_echo
    set -q config_debug; and echo $argv
end

#
# Basic exports.
#

set -x SHELL (which fish)
# set -x TERM 'xterm-kitty'
set -x TERM 'xterm-256color'

set -x LANG 'en_US.UTF-8'
set -x LC_ALL 'en_US.UTF-8'

set -x EDITOR 'code'
set -x VISUAL 'code'
set -x PAGER 'less'

set -x LESS '-iMRX'
set -x __batcommand (command -v bat)
set -x LESSOPEN "| $__batcommand --color=always %s"

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
source $fish_config_root'/secrets.fish'
# set to_source (ls -1 $fish_config_root'/source/' | rg '^[^_].+.fish')
# for fn in $to_source
#     debug_echo 'Sourcing '$fn
#     source $fish_config_root'/source/'$fn
# end

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

abbr -a gc   'git commit'
abbr -e gcm
abbr -a gcm  'git commit -m'
abbr -a ga   'git add'
abbr -a gia  'git add -p'
abbr -a st   'git status'
abbr -a gss  'git stash show'
abbr -a gssv 'git stash show -v'
abbr -a gsl  'git stash list'
abbr -a gpro 'git pull --rebase origin'
abbr -a gprom 'git pull --rebase origin master'

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
# alias gw='cd ~/workbench'
alias gd='cd ~/Dotfiles'

function profile_fish
    # See https://github.com/fish-shell/fish-shell/issues/2411
    set -l profiling_report_path (mktemp)
    fish --profile $profiling_report_path -ic 'fish_prompt; exit'; sort -nk 2 $profiling_report_path
end

# From source dir.

#
# Airbnb
#

function labinit
    bass source ~/.airlab/shellhelper.sh
end

set -gx JAVA_HOME (/usr/libexec/java_home -v 1.8)
set -gx PATH "$JAVA_HOME/bin" $PATH

#
# Python
#

function initconda
    set -l conda_path '/usr/local/anaconda3/bin/conda'
    test -f $conda_path; and eval $conda_path "shell.fish" "hook" $argv | source
end

function pt --wraps pytest
    pytest -s --pdb --pdbcls=IPython.terminal.debugger:Pdb $argv
end

#
# MacOS
#

if uname | grep -i '^darwin' > /dev/null
debug_echo 'Loading MacOS-specific config ...'

set -gx PATH '/usr/local/opt/coreutils/libexec/gnubin' $PATH
set -gx PATH '/usr/local/opt/unzip/bin' $PATH
set -gx PATH '/usr/local/opt/gnu-sed/libexec/gnubin' $PATH

function concat_pdf
    /System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py $argv
end

set brew_prefix (brew --prefix)
function gnu_manpath -a name
    echo $brew_prefix'/opt/'$name'/libexec/gnuman/'
end

function q --wraps man
    set -l brew_man_path (gnu_manpath 'coreutils') (gnu_manpath 'gnu-sed') (gnu_manpath 'gawk')
    set -l brew_man_path (string join ':' $brew_man_path)

    man -M $brew_man_path $argv 1>/dev/null 2>&1
    if test $status -eq 0
        man -M $brew_man_path $argv
    else
        man $argv
    end
end

# Enable kitty completions.
# which kitty > /dev/null
# if test $status -eq 0
#     kitty + complete setup fish | source
# end

function brew-commit --wraps brew
    set COMMIT $argv[1]
    set FORMULA $argv[2]
    brew install "https://raw.github.com/Homebrew/homebrew-core/$COMMIT/Formula/$FORMULA.rb" $argv[3..-1]
end

end
