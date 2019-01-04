set autojump_setup_fish (echo ~)'/local/share/autojump/autojump.fish'
if test -f $autojump_setup_fish
    source $autojump_setup_fish
end
