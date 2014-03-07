

# Enable color support of ls and also add handy aliases.

if [ -x /usr/bin/dircolors ]; then

    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"



    alias ls='ls --color=auto'

    alias dir='dir --color=auto'

    alias vdir='vdir --color=auto'



    alias grep='grep --color=auto'

    alias fgrep='fgrep --color=auto'

    alias egrep='egrep --color=auto'

fi



# Ls convenience aliases.

alias ll='ls -alF'

alias la='ls -A'

alias l='ls -CF'



# Detect text file encoding

alias detect_encoding='file -bi'



# Start notebook alias

alias ipnb='ipython notebook --profile=dmitry'



# Shortcut for git

alias g='git'

alias gs='git s'
