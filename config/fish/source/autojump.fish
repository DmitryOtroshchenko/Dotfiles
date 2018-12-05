set autojump_setup_fish (echo ~)'/.autojump/share/autojump/autojump.fish'
if test -f $autojump_setup_fish
    source $autojump_setup_fish
end
