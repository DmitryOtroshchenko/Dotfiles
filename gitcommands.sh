
function git_show_last() {
    if [ $# -eq 0 ]; then
        git show HEAD
    elif [ $# -eq 1 ]; then
        git show HEAD~$1
    else
        echo "$FUNCNAME() wrong call signature."
    fi
}

function git_show_stat() {
    if [ $# -eq 0 ]; then
        git log -1 --stat HEAD
    elif [ $# -eq 1 ]; then
        git log -1 --stat HEAD~$1
    else
        echo "$FUNCNAME() wrong call signature."
    fi
}

function git_interactive_rebase() {
    if [ $# -eq 0 ]; then
        git rebase -i HEAD~$1
    elif [ $# -eq 1 ]; then
        git rebase -i HEAD~$1
    else
        echo "$FUNCNAME() wrong call signature."
    fi
}

function git_news() {
    if [ $# -ne 0 ]; then
        echo "$FUNCNAME() wrong call signature."
        return 1
    fi

    # This command checks if the repo is clean.
    git diff-index --quiet HEAD --
    if [ $? -eq 0 ]; then
        git refresh
    else
        git stash && git refresh && git stash pop
    fi
}

function git_unpublished() {
    if [ $# -ne 0 ]; then
        echo "$FUNCNAME() wrong call signature."
        return 1
    fi

    HEAD_REF=$(git rev-parse --abbrev-ref HEAD)
    N_UNPUBLISHED=$(git rev-list --left-only --count $HEAD_REF...origin/master)
    git log -n $N_UNPUBLISHED
}

function git_fts() {
    if [ $# -ne 0 ]; then
        echo "$FUNCNAME() wrong call signature."
        return 1
    fi

    # Check if the working tree is dirty.
    git diff-index --quiet HEAD --
    if [ $? -eq 0 ]; then
        echo "Nothing to do here."
        return
    fi

    read -p "Do you really want to fuck this shit (y/n)? " CONT
    if [ "$CONT" = "y" ]; then
        git reset --hard head
        echo "All the shit is succesfully fucked."
    else
        echo "Fucking is a dish that is better served cold..."
    fi
}
