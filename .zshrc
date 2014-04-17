# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="my-af-magic"
ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often to auto-update? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to the command execution time stamp shown
# in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git virtualenv)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Default editor settings
export EDITOR='subl -w'

# Python stuff
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
workon py275

# Diff
alias fmerge='/Developer/Applications/FileMerge.app/Contents/MacOS/FileMerge -left $1 -right $2'

# Open man pages with Preview
pman () {
    man -t "${1}" | open -f -a /Applications/Preview.app
}

# Quicklook
alias ql='qlmanage -p 2>/dev/null'

alias -- .='pwd'
alias -- ..="cd .."
alias -- ...="cd .. ; cd .."
alias -- ....="cd .. ; cd .. ; cd .."

# Append to the Bash history file, rather than overwriting it
#shopt -s histappend

# Bind OPT + -> and OPT + <-
bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

# Postgres.app
PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"

# MongoDB
PATH="/Applications/MongoDB/bin:$PATH"

# Russian
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# IPython
alias ipnb="ipython notebook --matplotlib=inline --notebook-dir=/Users/dmitryotroshchenko/Documents/ipython"

# To compile stuff without pain...
export ARCHFLAGS="-Wno-error=unused-command-line-argument-hard-error-in-future"

# Git
alias g='git'
alias gs='git status'

# Colors
export TERM=xterm-256color

# For zsh.agnoster
export DEFAULT_USER=dmitryotroshchenko
