# .bashrc

# Do nothing if it's a non-interavtive session (e.g. scp).
# [ -z "$PS1" ] && return
if [ -z "$PS1" ]; then
    return;
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
function hpcat {
	hadoop fs -text $1 | sed 's/^...../0a/' | xxd -p -r
}
function pailcat {
	hdfs dfs -text $1 | sed 's/^...../0a/' | xxd -p -r
}

alias hfs='hadoop fs'
alias hls='hadoop fs -ls'
alias hrm='hadoop fs -rm'
alias hcat='hadoop fs -text'
alias hcp='hadoop distcp'
alias hcatseq='hadoop jar ~/criteo-hadoop-features.jar com.criteo.hadoop.cascading.utils.SequenceReader'

alias xtar='tar -xjvf'
alias ctar='tar -cjvf'

alias mjk='mapred job -kill'

function simprot() {
	hcat $1 | java -cp lib/criteo-hadoop-recocomputer.jar com.criteo.hadoop.recocomputer.utils.io.ProtobufUtil "ProductWithSimilarities"
}

function richprot() {
	hcat $1 | java -cp lib/criteo-hadoop-recocomputer.jar com.criteo.hadoop.recocomputer.utils.io.ProtobufUtil "EnrichedProduct"
}

function imgprot() {
	hcat $1 | java -cp lib/criteo-hadoop-recocomputer.jar com.criteo.hadoop.recocomputer.utils.io.ProtobufUtil "com.criteo.hadoop.recocomputer.jobs.imagedl.Image\$ProductImage"
}

function coevtprot() {
	hcat $1 | java -cp lib/criteo-hadoop-recocomputer.jar com.criteo.hadoop.recocomputer.utils.io.ProtobufUtil "com.criteo.hadoop.recocomputer.values.Coevent\$CoEvts"
}

# added by Anaconda3 2.4.1 installer
export PATH="/home/d.otroshchenko/anaconda3/bin:$PATH"

#
# BASH-IT
#

# Path to the bash it configuration
export BASH_IT="/home/d.otroshchenko/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='bobby_modified'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/xvzf/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# Load Bash It
source $BASH_IT/bash_it.sh

#
# Bash customizations
#

bind 'TAB:menu-complete'

alias ls="ls --group-directories-first --human-readable --color --sort=extension --classify --ignore=\"*.pyc\""

function cd {
    builtin cd "$@" && ls
}

# Use C-Z to restore the laste suspended job.
# See http://serverfault.com/questions/283678/whats-the-short-cut-for-fg-in-linux
# Alternatively: https://github.com/tybenz/ctrl-z
stty susp undef
bind '"\C-z":" fg\015"'

export LANG="en_US.UTF-8"

# Automatically reattach to tmux.
export PATH="$PATH:~/.local/bin"
if [ -z ${TMUX} ]; then
    tmux attach -t base || tmux new -s base
fi
