
if has('vim_starting')
    set nocompatible
endif

source ~/.vimrc_base

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"
" Automatically install vim-plug if absent.
"
let plug_script=expand('~/.vim/autoload/plug.vim')
if !filereadable(plug_script)
  echo "Installing vim-plug..."
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Plugin declarations.
call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc',         { 'do': 'make -f make_mac.mak' }

Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer --system-libclang' }

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_filepath_completion_use_working_dir = 1

" nnoremap tg :YcmCompleter GoToDefinitionElseDeclaration<CR>

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

" Plug 'fs111/pydoc.vim'
Plug 'gregsexton/gitv'
Plug 'thinca/vim-ref'
Plug 'gosukiwi/vim-atom-dark'

Plug 'ervandew/supertab'
Plug 'sirver/ultisnips'

let g:UltiSnipsExpandTrigger='<c-Space>'
let g:UltiSnipsListSnippets='<c-Tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

Plug 'honza/vim-snippets'

" Plug 'fmoralesc/vim-pad'

" let g:pad#dir = '~/testnotes/'
" let g:pad#default_format = 'pandoc'

Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/vimshell.vim'
Plug 'gcmt/wildfire.vim'

Plug 'jimsei/winresizer'

let g:winresizer_keycode_left = 106 " j
let g:winresizer_keycode_right = 108 " l
let g:winresizer_keycode_down = 107 " k
let g:winresizer_keycode_up = 104 " h
let g:winresizer_keycode_finish = 13 " ENTER
let g:winresizer_keycode_cancel = 27 " ESC

Plug 'tshirtman/vim-cython'
Plug 'Lokaltog/vim-easymotion'
Plug 'danro/rename.vim' " OK
Plug 'hdima/python-syntax' " OK
Plug 'itchyny/lightline.vim'
Plug 'jmcantrell/vim-virtualenv' " OK
Plug 'luochen1990/rainbow' " NOK: fix terminal colors.
Plug 'majutsushi/tagbar'
Plug 'moll/vim-bbye'
Plug 'michaeljsmith/vim-indent-object' " OK
Plug 'sjl/gundo.vim'
Plug 'szw/vim-maximizer' " OK
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'vim-scripts/loremipsum' " OK
" Plug 'mtth/scratch.vim' " NOK change mappings, make them optional
Plug 'JuliaLang/julia-vim' " OK
Plug 'Raimondi/delimitMate'
" Plug 'alfredodeza/khuno.vim'

" Search and substitution "{{{
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'osyo-manga/vim-anzu'

" An alternative to vim-asterisk
" Plug 'thinca/vim-visualstar'
"}}}

" A lot of vim colorschemes including solarized.
Plug 'flazz/vim-colorschemes' " OK
Plug 'justinmk/vim-gtfo' " NOK, tune mappings
Plug 'airblade/vim-gitgutter' " OK

Plug 'mileszs/ack.vim'

let g:ack_default_options = " -s -H --nocolor --nogroup --smart-case --sort-files --follow"
let g:ackhighlight = 1
" let g:ack_autofold_results = 1
let g:ackpreview = 1
let g:ack_use_dispatch = 1

Plug 'itspriddle/vim-marked' " OK, edited
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-voom/VOoM'
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'
Plug 'svermeulen/vim-easyclip'
Plug 'csexton/trailertrash.vim' " OK
" A good plugit for code and text tables alignment.
Plug 'junegunn/vim-easy-align' " OK

" Plug 'mattdbridges/bufkill.vim'
" Plug 'xolox/vim-misc'
" Plug 'jeetsukumaran/vim-markology'
" Plug 'Yggdroot/indentLine'

" " Plug 'chrisbra/NrrwRgn'
" " Plug 'wikimatze/hammer.vim'
" Plug 'chrisbra/csv.vim'
" " Plug 'szw/vim-ctrlspace'

if has("gui_running")
    " GUI-only plugins
else
    " Terminal-only plugins
    Plug 'edkolev/promptline.vim'
    Plug 'edkolev/tmuxline.vim'
    Plug 'ervandew/screen'
    " Plug 'godlygeek/csapprox'
    " Plug 'carlobaldassi/vim-colorschemedegrade'
endif

" End of plugin declarations.
call plug#end()

"
" colorscheme is a plugin.
"

let g:solarized_contrast="normal"
let g:solarized_diffmode="normal"
let g:solarized_menu=0
let g:solarized_hitrail=1
colorscheme solarized

" Line number should have the same color as the rest of the workspace.
highlight LineNr ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" Sign column should have the same color as the rest of the workspace.
highlight SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup markdown
    autocmd!
    autocmd BufNewFile,BufReadPost,BufWritePost *.md set filetype=pandoc
    autocmd BufNewFile,BufReadPost,BufWritePost *.md set syntax=pandoc
    autocmd BufNewFile,BufReadPost,BufWritePost *.md set syntax=pandoc
    autocmd BufNewFile,BufReadPost,BufWritePost *.md hi Conceal cterm=NONE ctermbg=NONE ctermfg=red gui=NONE guifg=red guibg=NONE
augroup END " markdown

augroup trim_trailing_whitespace
    autocmd!
    autocmd FileType * autocmd BufWritePre <buffer> :TrailerTrim
augroup END " trim_trailing_whitespace

augroup trail
    autocmd!
    autocmd InsertEnter * TrailerHide
    autocmd InsertLeave * TrailerShow
augroup END " trail

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" haya14busa/incsearch.vim "{{{

let g:incsearch#consistent_n_direction = 1
let g:incsearch#do_not_save_error_message_history = 1
let g:incsearch#magic = '\v' " very magic
let g:incsearch#smart_backward_word = 1
let g:incsearch#separate_highlight = 1

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-stay)
map g/ <Plug>(incsearch-stay)

augroup incsearch-keymap
    autocmd!
    autocmd VimEnter * call s:incsearch_keymap()
augroup END

function! s:incsearch_keymap()
    IncSearchNoreMap <Tab>   <Over>(buffer-complete)
    IncSearchNoreMap <S-Tab> <Over>(buffer-complete-prev)
endfunction

"}}}

" haya14busa/vim-asterisk "{{{

" Do not move cursor when searching
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

" osyo-manga/vim-anzu "{{{

nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
" nmap * <Plug>(anzu-star-with-echo)
" nmap # <Plug>(anzu-sharp-with-echo)

" "}}}

"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:unite_source_yank_history_save_clipboard = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_limit = 40
let g:unite_winheight = 12
let g:unite_update_time = 100

call unite#filters#matcher_default#use(['matcher_fuzzy'])

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'' '
    let g:unite_source_grep_recursive_opt = ''
endif


" Set "-no-quit" automatically in grep unite source.
call unite#custom#profile('source/grep', 'context', {
\   'no_quit' : 1
\ })

call unite#custom#source('file,file/new,buffer,file_rec', 'matchers', 'matcher_fuzzy')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" '⋮', '⁞', '┊', '┆', '│'
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ],
    \             [ 'reg' ] ]
    \ },
    \ 'component_function': {
    \   'reg': 'MyRegisterContents',
    \   'fileformat': 'MyFileformat',
    \   'fileencoding': 'MyFileencoding',
    \ },
    \ 'component': {
    \   'readonly': '%{ &filetype == "help" ? "" : &readonly? "\u2716" : "" }',
    \   'modified': '%{ &filetype == "help" ? "" : &modified ? "+" : &modifiable ? "" : "-" }'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&filetype!="help"&& &readonly)',
    \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \   'reg': 'winwidth(0) > 70'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '⋮', 'right': '⋮' },
    \ 'tabline': { 'right': [] },
    \ }

function! MyFileformat()
    return &fileformat =~ 'unix' ? '' : &fileformat
endfunction

function! MyFileencoding()
    return &fenc =~ 'utf-8' ? '' : &fenc
endfunction

let g:max_statusline_reg_contents_len = 25

function! StripWS(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! ShrinkWS(input_string)
    return substitute(a:input_string, '\s\+', ' ', 'g')
endfunction

function! MyRegisterContents()
    " TODO: add caching.
    let reg_contents = @"
    let reg_contents = ShrinkWS(reg_contents)
    let reg_contents = StripWS(reg_contents)
    let reg_contents = strtrans(reg_contents) " substitute(reg_contents, '\n', '¬ ', '')
    if strlen(reg_contents) >= g:max_statusline_reg_contents_len
        let trimmed = strpart(reg_contents, 0, g:max_statusline_reg_contents_len)
        let trimmed = trimmed . '…'
        let prepared = trimmed
    else
        let prepared = reg_contents
    endif
    return winwidth(0) > 78 ? prepared : ''
endfunction

function! s:filtered_lightline_call(funcname)
    if bufname('%') == '__CS__'
        return
    endif
    execute 'call lightline#' . a:funcname . '()'
endfunction

augroup LightLine
    autocmd!
    autocmd WinEnter,BufWinEnter,FileType,ColorScheme * call s:filtered_lightline_call('update')
    autocmd ColorScheme,SessionLoadPost * call s:filtered_lightline_call('highlight')
    autocmd CursorMoved,BufUnload * call s:filtered_lightline_call('update_once')
augroup END

let g:tmuxline_powerline_separators = 0
let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '⋮',
    \ 'right' : '',
    \ 'right_alt' : '⋮',
    \ 'space' : ' '}

let g:promptline_powerline_symbols = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-pandoc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:pandoc#filetypes#handled = ['markdown', 'textile']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" riv
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! RivSetup()
    setl foldmethod=expr
    setl foldexpr=riv#fold#expr(v:lnum)
    setl foldtext=riv#fold#text()
endfunction

augroup rest
    au!
    au FileType rst call RivSetup()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lokaltog/vim-easymotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
let g:EasyMotion_do_shade = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Yggdroot/indentLine
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" '⋮', '⁞', '┊', '┆', '│'
let g:indentLine_enabled = 1
let g:indentLine_char = "⋮"
let g:indentLine_first_char = "⋮"
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#4A4A4F'
" let g:indentLine_color_gui = '#FF0000'
let g:indentLine_noConcealCursor = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tagbar_autofocus = 1
let g:tagbar_sort = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gundo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gundo_preview_bottom = 1
let g:gundo_right = 1
let g:gundo_help = 0
let g:gundo_preview_statusline = 'history preview'
let g:gundo_tree_statusline = 'undo tree'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:syntastic_python_checkers = ['python', 'pylama', 'py3kwarn']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimfiler
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vimfiler_as_default_explorer = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python-syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let python_highlight_all = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" wildfire
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:wildfire_objects = ["i'", "a'", 'i"', 'a"', "i)", "a)", "i]", "a]", "i}", "a}", "ip", "it"]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" khuno
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:khuno_ignore="E202,E128"
let g:khuno_max_line_length=100

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bufkill and bbye
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" let g:BufKillCreateMappings = 0
" noremap <Leader>x :BD<CR>
noremap <Leader>x :Bdelete<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlspace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlspace_set_default_mapping = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markology
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let markology_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'`^<>[]\""

let g:markology_textlower = "\t "
let g:markology_textupper = "\t "
let markology_textother = "\t "

let g:markology_hlline_lower = 0
let g:markology_hlline_upper = 0
let markology_hlline_other = 0

" MarkologyHLl
" MarkologyHLu
" MarkologyHLo
" MarkologyHLm
" MarkologyHLLine

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rainbow_parentheses
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:rainbow_active = 1
let g:rainbow_conf = {
    \ 'guifgs':   ['#e6dfce', '#b58900', '#d33682', '#859900'] }
    " \ 'ctermfgs': ['Red3', 'cyan', 'DarkOrange', 'green'] }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-gtfo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gtfo#terminals = { 'mac' : 'iterm' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" trailertrash
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

hi UnwantedTrailerTrash guibg=#DA3435 ctermbg=red

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gitgutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gitgutter_sign_column_always = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iabbrev teh the
iabbrev fo of
iabbrev @@ dmitry.otroshchenko@gmail.com

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin mappings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Unite.vim
noremap <Leader>b :Unite -no-split -buffer-name=buffers buffer<CR>
noremap <Leader>t :Unite -no-split -buffer-name=fb -input=** -start-insert buffer file_rec/async<CR>

" EasyClip
noremap <silent> <leader>y :Yanks<CR>
map M m$

let g:EasyClipUseSubstituteDefaults = 0
nmap <silent> gs <plug>SubstituteOverMotionMap
nmap gss <plug>SubstituteLine
xmap gs <plug>XEasyClipPaste

" EasyMotion
map <SPACE> <Plug>(easymotion-prefix)

nmap s         <Plug>(easymotion-s2)
xmap s         <Plug>(easymotion-s2)
omap s         <Plug>(easymotion-s2)

nmap f         <Plug>(easymotion-f)
xmap f         <Plug>(easymotion-f)
omap f         <Plug>(easymotion-f)

nmap F         <Plug>(easymotion-F)
xmap F         <Plug>(easymotion-F)
omap F         <Plug>(easymotion-F)

nmap t         <Plug>(easymotion-t)
xmap t         <Plug>(easymotion-t)
omap t         <Plug>(easymotion-t)

nmap T         <Plug>(easymotion-T)
xmap T         <Plug>(easymotion-T)
omap T         <Plug>(easymotion-T)

nmap <Plug>(easymotion-prefix)k <Plug>(easymotion-j)
xmap <Plug>(easymotion-prefix)k <Plug>(easymotion-j)
omap <Plug>(easymotion-prefix)k <Plug>(easymotion-j)

nmap <Plug>(easymotion-prefix)h <Plug>(easymotion-k)
xmap <Plug>(easymotion-prefix)h <Plug>(easymotion-k)
omap <Plug>(easymotion-prefix)h <Plug>(easymotion-k)

" noremap <Plug>(easymotion-lineanywhere)

nmap <Leader>f <Plug>(easymotion-sn)
xmap <Leader>f <Plug>(easymotion-sn)
omap <Leader>f <Plug>(easymotion-sn)

" Maximizer
noremap <C-W><C-Z> :MaximizerToggle<CR>
noremap <C-W>z     :MaximizerToggle<CR>
noremap <C-W>Z     :MaximizerToggle<CR>

" Vimfiler
noremap <F4> :VimFiler -toggle<CR>

" Gundo
noremap <F5> :GundoToggle<CR>

" Tagbar
noremap <F6> :TagbarOpenAutoClose<CR>

" Khuno
noremap <silent><Leader>sc <Esc>:Khuno show<CR>

" Ctrlspace
noremap `<Space> :CtrlSpace<CR>

" Markology
" noremap <silent> mm :MarkologyPlaceMarkToggle<CR>

" Marked
noremap <leader>md :MarkedOpen<CR>
noremap <leader>mq :MarkedQuit<CR>

" tcomment
let g:tcommentMapLeaderOp1='<leader>c'
let g:tcommentMapLeaderUncommentAnyway='<leader><'
let g:tcommentMapLeaderCommentAnyway='<leader>>'

" For tmux support
let g:ScreenImpl = 'Tmux'
let vimrplugin_screenvsplit = 1 " For vertical tmux split
let g:ScreenShellInitialFocus = 'shell'
" instruct to use your own .screenrc file
let g:vimrplugin_noscreenrc = 1

" surround
let g:surround_{char2nr("d")} = "\\text{\r}"

" TODO: Add a map to alternate buffers.
" TODO: change statusline color.
" TODO: change cursor color to white.
