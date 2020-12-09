fish_vi_key_bindings

# set config_debug 1
function debug_echo
    set -q config_debug; and echo $argv
end

function lpath
    debug_echo "LPush PATH: $argv"
    set -gx PATH $argv $PATH
end

function rpath
    debug_echo "RPush PATH: $argv"
    set -gx PATH $PATH $argv
end

set dotfiles_root (echo ~)'/Dotfiles/'

lpath '/usr/local/opt/gnu-sed/libexec/gnubin'
lpath '/usr/local/opt/unzip/bin'
lpath '/usr/local/bin'
lpath "$HOME/.local/bin"
lpath "$HOME/.cargo/bin"

#
# Basic exports.
#

set -gx SHELL (which fish)
# set -gx TERM 'xterm-kitty'
set -gx TERM 'xterm-256color'

set -gx LANG 'en_US.UTF-8'
set -gx LC_ALL 'en_US.UTF-8'

set -gx EDITOR 'code'
set -gx VISUAL 'code'
set -gx PAGER 'less'

# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
set -gx LESS '-FgiMRX -z-4'
set -gx __batcommand (command -v bat)
set -gx LESSOPEN "| $__batcommand --color=always %s"
alias cat='bat'

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

alias ls='ls --group-directories-first -h --color --sort=extension --classify --hide="*.pyc" --hide="__pycache__"'

alias md='mkdir -p'
alias rd='rmdir'
alias mv='mv -i'
alias cp='cp -i'
alias cb='cd -'

set -gx RIPGREP_CONFIG_PATH $dotfiles_root'/config/ripgreprc'

#
# Git goodies.
#

abbr -a g     'git'
abbr -a gc    'git commit'
abbr -e gcm
abbr -a gcm   'git commit -m'
abbr -a ga    'git add'
abbr -a gia   'git add -p'
abbr -a st    'git status -bs'
abbr -a gss   'git stash show'
abbr -a gssv  'git stash show -v'
abbr -a gsl   'git stash list'
abbr -a gsh   'git show head'
abbr -a gpro  'git pull --rebase origin'
abbr -a gprom 'git pull --rebase origin master'
abbr -a gpu   'git push -u'

abbr -a master 'git checkout master'

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

function profile_fish
    # See https://github.com/fish-shell/fish-shell/issues/2411
    set -l profiling_report_path (mktemp)
    fish --profile $profiling_report_path -ic 'fish_prompt; exit'; sort -nk 2 $profiling_report_path
end

# TODO: integrate to launcher.
alias dot="$EDITOR ~/Dotfiles"

function initrust
    source (echo ~)'/.cargo/env'
end
initrust

#
# Airbnb
#

function initlab
    bass source ~/.airlab/shellhelper.sh
end

alias dev='set -gx ENV development'
alias staging='set -gx ENV staging'
alias prod='set -gx ENV production'

set -gx JAVA_HOME (/usr/libexec/java_home -v 1.8)
lpath "$JAVA_HOME/bin"

lpath '/opt/airbnb/bin/'

function nvm
   bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
# nvm use default --silent

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
# Fzf
#

set -gx FZF_DEFAULT_COMMAND 'fd --type f'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_DEFAULT_OPTS ''
# set -gx FZF_CTRL_R_OPTS "--preview 'echo {} | bat -l bash' --preview-window down:3:hidden:wrap --bind 'ctrl-q:toggle-preview'"
set -gx FZF_CTRL_R_OPTS "--preview 'echo {} | bat -l bash' --preview-window down:3:hidden:wrap --bind 'ctrl-q:toggle-preview'"

set -gx BAT_CONFIG_PATH $dotfiles_root'/config/batrc'

function __autojump_fzf
    set -l CHOICE (
        cat (echo ~)'/Library/autojump/autojump.txt' |
        sort -nr |
        awk -F '\t' '{print $NF}' |
        fzf +s -q "$argv"
    )
    if test $status -eq 0
        set_color magenta --bold; echo "-> $CHOICE"; echo
        cd $CHOICE
    end
end
alias j='__autojump_fzf'

function choose-git-branch
    git rev-parse --show-toplevel > /dev/null 2>&1
    if test $status -ne 0
        return 1
    end
    git branch -v | sk | sd '\s*\**\s+(\S+)\s+.*' '$1'
end

bind_all \cg 'set -l chosen_branch (choose-git-branch); and test -n "$chosen_branch"; and commandline -i "$chosen_branch"'

#
# MacOS
#

if uname | grep -i '^darwin' > /dev/null

debug_echo 'Loading MacOS-specific config ...'

lpath '/usr/local/opt/coreutils/libexec/gnubin'

function concat_pdf
    /System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py $argv
end

# set brew_prefix (brew --prefix)
# function gnu_manpath -a name
#     echo $brew_prefix'/opt/'$name'/libexec/gnuman/'
# end

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
