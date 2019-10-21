
function bind_all --wraps 'bind'
    bind -M default $argv
    bind -M visual $argv
    bind -M insert $argv
end


function bind_nv --wraps 'bind'
    bind -M default $argv
    bind -M visual $argv
end


function fancy_cz
    set current_cl (commandline)
    fg
    commandline -f repaint
    commandline -r $current_cl
end


function fish_user_key_bindings
    bind_all \cw 'backward-kill-word'
    # One of these is option + backspace.
    # for Mac with Karabiner remap C-w -> option + backspace.
    bind_all \e\x7f 'backward-kill-word'
    bind_all \e\b 'backward-kill-word'

    bind_all \ca 'beginning-of-line'
    bind_all \ce 'end-of-line'
    bind_all \cp 'history-search-backward'
    bind_all \cn 'history-search-forward'
    bind_all \cq 'echo; pwd; echo; ls; commandline -f repaint'
    bind_all \cl 'clear; commandline -f repaint'

    # bind_all \ck 'fancy_cz'

    bind_nv yy fish_clipboard_copy
    bind_nv Y fish_clipboard_copy
    bind_nv p fish_clipboard_paste
end

fzf_key_bindings
