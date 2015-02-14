
" Looks like it does not work.
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

hi Cursor        guifg=#fdf6e3 guibg=#2aa198
" hi NormalCursor  guifg=#fdf6e3 guibg=#5489ce
hi NormalCursor  guifg=#fdf6e3 guibg=#2aa198
hi InsertCursor  guifg=#fdf6e3 guibg=#b58900 " #8a9824
hi VisualCursor  guifg=#fdf6e3 guibg=#d33682
hi ReplaceCursor guifg=#fdf6e3 guibg=#dc322f
hi CommandCursor guifg=#fdf6e3 guibg=#cb4b16

" Turn off blinking.
set gcr=a:block-Cursor

" Mode aware cursors.
set gcr+=o:hor50-NormalCursor
set gcr+=n:NormalCursor
set gcr+=i-ci-sm:InsertCursor
set gcr+=r-cr:ReplaceCursor-hor20
set gcr+=c:InsertCursor
set gcr+=v-ve:VisualCursor

set gcr+=a:blinkon0
