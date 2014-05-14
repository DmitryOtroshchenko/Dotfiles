
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

export UPDATE_ZSH_DAYS=7

# Optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git virtualenv colored-man brew)

source $ZSH/oh-my-zsh.sh

# User configuration

bindkey -v

export PATH="$HOME/bin:/usr/local/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    # export EDITOR='subl -w'
    export EDITOR='vim'
else
    export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# To compile stuff without pain on Mac
export ARCHFLAGS="-Wno-error=unused-command-line-argument-hard-error-in-future"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Python stuff
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
workon py275

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

# Postgres.app
PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"

# MongoDB
PATH="/Applications/MongoDB/bin:$PATH"

# Russian
export LANG=en_US.utf8

# IPython
alias ipnb="ipython notebook --matplotlib=inline --notebook-dir=/Users/dmitryotroshchenko/Documents/ipython"

# Git
alias g='git'
alias gs='git status'

# Colors
export TERM=xterm-256color

# For zsh.agnoster
export DEFAULT_USER=dmitryotroshchenko

alias detect_encoding='file -bi'
