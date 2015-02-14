
hi Cursor        guifg=#fdf6e3 guibg=#2aa198
" hi NormalCursor  guifg=#fdf6e3 guibg=#5489ce
hi NormalCursor  guifg=#fdf6e3 guibg=#2aa198
hi InsertCursor  guifg=#fdf6e3 guibg=#b58900 " #8a9824
hi VisualCursor  guifg=#fdf6e3 guibg=#d33682
hi ReplaceCursor guifg=#fdf6e3 guibg=#dc322f
hi CommandCursor guifg=#fdf6e3 guibg=#cb4b16

" Turn off blinking.
set guicursor=a:block-Cursor

" Mode aware cursors.
set guicursor+=o:hor50-NormalCursor
set guicursor+=n:NormalCursor
set guicursor+=i-ci-sm:InsertCursor
set guicursor+=r-cr:ReplaceCursor-hor20
set guicursor+=c:InsertCursor
set guicursor+=v-ve:VisualCursor

set guicursor+=a:blinkon0

" Looks like it does not work.
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" Change cursor to vertical bar in insert mode when using iTerm2
" if $TERM_PROGRAM == 'iTerm.app'
"     if exists('$TMUX')
"         let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"         let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"     else
"         let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"         let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"     endif
" endif
