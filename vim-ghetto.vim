
Plug 'gelguy/Cmd2.vim'
Plug 'bling/vim-airline'

let g:airline_powerline_fonts = 0
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 0

" Plug 'fs111/pydoc.vim'

" Plug 'fmoralesc/vim-pad'

" let g:pad#dir = '~/testnotes/'
" let g:pad#default_format = 'pandoc'

Plug 'jimsei/winresizer'

let g:winresizer_keycode_left = 106 " j
let g:winresizer_keycode_right = 108 " l
let g:winresizer_keycode_down = 107 " k
let g:winresizer_keycode_up = 104 " h
let g:winresizer_keycode_finish = 13 " ENTER
let g:winresizer_keycode_cancel = 27 " ESC

" Plug 'wellle/targets.vim'
" Plug 'paradigm/TextObjectify'
"
" let g:textobjectify = {
"     \ '-': {'left': '\v\s|\n|_', 'right': '\v\s|\n|_', 'same': 1, 'seek': 0, 'line': 0},
" \ }

" Plug 'mtth/scratch.vim' " NOK change mappings, make them optional

" Plug 'alfredodeza/khuno.vim'

" An alternative to vim-asterisk
" Plug 'thinca/vim-visualstar'

" Plug 'mattdbridges/bufkill.vim'
" Plug 'jeetsukumaran/vim-markology'

let markology_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'`^<>[]\""

let g:markology_textlower = '\t '
let g:markology_textupper = '\t '
let markology_textother = '\t '

let g:markology_hlline_lower = 0
let g:markology_hlline_upper = 0
let markology_hlline_other = 0

" MarkologyHLl
" MarkologyHLu
" MarkologyHLo
" MarkologyHLm
" MarkologyHLLine

" Plug 'Yggdroot/indentLine'

" '⋮', '⁞', '┊', '┆', '│'
let g:indentLine_enabled = 1
let g:indentLine_char = '⋮'
let g:indentLine_first_char = '⋮'
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#4A4A4F'
" let g:indentLine_color_gui = '#FF0000'
let g:indentLine_noConcealCursor = 1

" " Plug 'chrisbra/NrrwRgn'
" " Plug 'wikimatze/hammer.vim'
" Plug 'chrisbra/csv.vim'

" Terminal-only plugins
Plug 'edkolev/promptline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'ervandew/screen'
" Plug 'godlygeek/csapprox'
" Plug 'carlobaldassi/vim-colorschemedegrade'

Plug 'kana/vim-submode'
Plug 'tomtom/tinykeymap_vim'

let g:tinykeymaps_default = []
let g:tinykeymap#resolution = 10
call tinykeymap#EnterMap('splits', '<C-W>m', {'name': 'Splits mode'})
call tinykeymap#Map('splits', 'n', 'vertical resize -3')
call tinykeymap#Map('splits', 'e', 'resize -3')
call tinykeymap#Map('splits', 'i', 'resize +3')
call tinykeymap#Map('splits', 'o', 'vertical resize +3')

Plug 'sjl/vitality.vim'

Plug 't9md/vim-choosewin'

nmap - <Plug>(choosewin)
let g:choosewin_tablabel = 'qwfpluy'
let g:choosewin_label = 'arstneio'
let g:choosewin_statusline_replace = 0
let g:choosewin_tabline_replace = 0
let g:choosewin_blink_on_land = 0
let g:choosewin_overlay_enable = 1
let g:choosewin_overlay_clear_multibyte = 1
let g:choosewin_overlay_shade = 1
" TODO: for now it does not work: no choosewin appears
" even if there are other tabs to choose.
let g:choosewin_return_on_single_win = 0

let g:choosewin_color_label = { 'gui': ['#596E75', '#EEE8D6', 'bold'], 'cterm': [] }
let g:choosewin_color_label_current = { 'gui': ['#0A3641', '#EEE8D6', 'bold'], 'cterm': [] }
let g:choosewin_color_other = { 'gui': ['#EEE8D6', 'black'], 'cterm': [] }
let g:choosewin_color_overlay = { 'gui': ['DarkGreen', 'DarkGreen' ], 'cterm': [ 22, 22 ] }
let g:choosewin_color_overlay_current = { 'gui': ['LimeGreen', 'LimeGreen' ], 'cterm': [ 40, 40 ] }
let g:choosewin_color_land = { 'gui':[ 'LawnGreen', 'Black', 'bold,underline'], 'cterm': ['magenta', 'white'] }
let g:choosewin_color_shade = { 'gui':[ '', '#777777'], 'cterm': ['', 'grey'] }
