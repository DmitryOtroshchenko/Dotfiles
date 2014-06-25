
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <NeoBundle>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('vim_starting')
    set nocompatible
    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \    },
    \ }

" NeoBundle 'Valloric/YouCompleteMe', {
"     \ 'build' : {
"     \      'mac' : './install.sh --clang-completer --system-libclang',
"     \      'unix' : './install.sh --clang-completer --system-libclang',
"     \     },
"     \ }
" NeoBundle 'ervandew/supertab'
set completeopt+=longest

inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <expr><Tab>
    \ neocomplete#complete_common_string() != '' ?
    \ neocomplete#complete_common_string() :
    \ pumvisible() ? "\<C-l>" : "\<Tab>"

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neossh.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/wildfire.vim'

NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'danro/rename.vim'
NeoBundle 'dhruvasagar/vim-table-mode'
NeoBundle 'edkolev/promptline.vim'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'hdima/python-syntax'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'jmcantrell/vim-virtualenv'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'mattdbridges/bufkill.vim'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'rking/ag.vim'
NeoBundle 'sjl/gundo.vim/'
NeoBundle 'szw/vim-ctrlspace'
NeoBundle 'szw/vim-maximizer'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/loremipsum'

NeoBundle 'chrisbra/NrrwRgn'
NeoBundle 'suan/vim-instant-markdown'
" NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'maxbrunsfeld/vim-yankstack'
NeoBundle 'wikimatze/hammer.vim'
NeoBundle 'wmvanvliet/vim-ipython'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" </NeoBundle>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

call yankstack#setup()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

if has("gui_running")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h16
    set guioptions=acimgr
endif

if has("mac")
    set macmeta
endif

" GUI
set showtabline=2
set guicursor+=a:blinkon0
set mousemodel=popup_setpos

" UI
set title
set showcmd
set showmode

" Splits tabs and sessions
set laststatus=2
set splitbelow
set splitright
" Do not store global and local values in a session.
set ssop-=options
" Do not store folds.
set ssop-=folds

" Turns off all error bells, visual or otherwise.
set noerrorbells
set visualbell
set t_vb=
" autocmd vimrc GUIEnter * set visualbell t_vb=

set wildignorecase
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.pyc,*.pyo,*.hi,*.swp
set completeopt-=preview

" Colors
syntax on
set background=dark
colorscheme Monokai

" highlight Search      ctermfg=235     ctermbg=186     cterm=NONE
"                     \ guifg=#272822   guibg=#e6db74   gui=NONE
" highlight IncSearch   ctermfg=235     ctermbg=186     cterm=NONE
"                     \ guifg=#272822   guibg=#e6db74   gui=NONE
highlight LineNr        ctermfg=DarkGrey ctermbg=NONE   cterm=NONE
                      \ guifg=DarkGrey  guibg=NONE      gui=NONE
highlight WildMenu      ctermfg=148     ctermbg=240     cterm=bold
                      \ guifg=#a6e22e   guibg=#585858   gui=bold
highlight StatusLine    ctermfg=15      ctermbg=236     cterm=NONE
                      \ guifg=#ffffff   guibg=#303030   gui=NONE
highlight Pmenu         ctermfg=NONE    ctermbg=237     cterm=NONE
                      \ guifg=NONE      guibg=#3a3a3a   gui=NONE

" Indentation
set nowrap
set copyindent
set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4
set shiftround
set autoindent
set smarttab

" Code folding
set foldmethod=indent
set foldlevel=99

" Navigation
set number
set relativenumber
set numberwidth=4
set cursorline
set nocursorcolumn
set colorcolumn=80
set scrolloff=3
set virtualedit=block,onemore

" Regexes and al.
if v:version >= 704
    " The new Vim regex engine is currently slooooow as hell which makes syntax
    " highlighting slow, which introduces typing latency.
    " Consider removing this in the future when the new regex engine becomes
    " faster.
    set regexpengine=1
endif

set gdefault
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Encodings and symbols
set encoding=utf-8
set fileformats=unix,dos,mac
set list
set listchars=tab:▸⋅,nbsp:⋅,trail:⋅,eol:¬,extends:❯,precedes:❮

" Misc
set clipboard=unnamed
set confirm
set nobackup
set nowritebackup
set noswapfile
set autoread
set autowrite
set history=1000
set undolevels=1000

set backspace=indent,eol,start
if has('mouse')
    set mouse=a
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup _python
    autocmd!
    " autocmd FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class,with
    " autocmd FileType pyrex setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

augroup markdown
    autocmd!
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END " markdown

augroup git_diff
    autocmd!
    " Show Git diff in window split when commiting git diff.
    autocmd FileType gitcommit DiffGitCached | wincmd p
    " Turn on spellcheck.
    autocmd BufRead COMMIT_EDITMSG setlocal spell!
augroup END " git_diff

augroup trim_trailing_whitespace
    autocmd!
    autocmd FileType c,cpp,java,php,python,markdown,r,sql,vim autocmd BufWritePre <buffer> :%s/\s\+$//e
augroup END " trim_trailing_whitespace

augroup misc
    autocmd!
    " Autotoggle cursor line.
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
    autocmd InsertEnter * set nocursorline
    autocmd InsertLeave * set cursorline
    " Paste mode auto-off.
    autocmd InsertLeave * set nopaste
    " Absolute line numbers in insert mode, relative otherwise for easy movement.
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END " misc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:unite_source_yank_history_save_clipboard = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_limit = 40
let g:unite_winheight = 12
let g:unite_update_time = 100

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'' '
    let g:unite_source_grep_recursive_opt = ''
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YankRing.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:yankring_max_history = 20
let g:yankring_min_element_length = 2
let g:yankring_paste_using_g = 1
let g:yankring_window_height = 12
let g:yankring_window_use_bottom = 0
let g:yankring_manage_numbered_reg = 1
let g:yankring_clipboard_monitor = 1
let g:yankring_manual_clipboard_check = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" '⋮', '⁞', '┊', '┆', '│'
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'enable': { 'tabline': 0 },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ],
      \             [ 'reg' ] ]
      \ },
      \ 'component_function': {
      \   'reg': 'MyRegisterContents'
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '⋮', 'right': '⋮' }
      \ }

let g:max_statusline_reg_contents_len = 25

function! StripWS(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! ShrinkWS(input_string)
    return substitute(a:input_string, '\s\+', ' ', 'g')
endfunction

function! MyRegisterContents()
    " TODO: add caching.
    let reg_contents = @+
    let reg_contents = ShrinkWS(reg_contents)
    let reg_contents = StripWS(reg_contents)
    let reg_contents = substitute(reg_contents, '\n', '¬ ', '')
    if strlen(reg_contents) >= g:max_statusline_reg_contents_len
        let trimmed = strpart(reg_contents, 0, g:max_statusline_reg_contents_len)
        let trimmed = trimmed . '…'
        return trimmed
    else
        return reg_contents
    endif
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
" Valloric/YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1

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
" bufkill
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:BufKillCreateMappings = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplete and neosnippet
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#max_list = 250
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_cursor_hold_i = 1
let g:neocomplete#enable_refresh_always = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlspace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlspace_set_default_mapping = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iabbrev teh the
iabbrev fo of
iabbrev @@ dmitry.otroshchenko@gmail.com

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymap
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set pastetoggle=<F2>
" I can type :help on my own, thanks.
noremap <F1> <Esc>
inoremap jk <Esc>
inoremap kj <Esc>

nnoremap ; :
vnoremap ; :

nnoremap ,cd :cd %:p:h<CR>

map Y y$
noremap <Leader>A ggVG

nnoremap <leader>ss :source $MYVIMRC<CR>
nnoremap <leader>se :split  $MYVIMRC<CR>

" TODO:
" Bind :set wrap linebreak nolist
" nmap <C-J> o<Esc>
" nmap <C-K> O<Esc>
" nnoremap <C-J> m`o<Esc>``
" nnoremap <C-K> m`O<Esc>``
nnoremap K i<CR><Esc>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0
inoremap <C-d> <C-o>dd

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <M-h> :vertical resize -5<CR>
map <M-j> :resize +5<CR>
map <M-k> :resize -5<CR>
map <M-l> :vertical resize +5<CR>

map <leader>] :BF<CR>
map <leader>[ :BB<CR>
map <leader>x :BD<CR>
map <leader>X :bd<CR>

nmap <Leader>/ :set hlsearch! hlsearch?<CR>
nmap <Leader>w :set wrap! wrap?<CR>

" Don't loose selection after indenting in visual mode.
vnoremap < <gv
vnoremap > >gv

" Up-down through long lines chunks.
map j gj
map <down> gj
map k gk
map <up> gk

cmap w!! w !sudo tee % >/dev/null

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin mappings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Unite.vim
nnoremap <Leader>b  :Unite -no-split -buffer-name=buffers buffer<CR>
nnoremap <Leader>tt :Unite -no-split -buffer-name=fb -input=** -start-insert buffer file_rec/async<CR>

" YankRing and yankstack
" nnoremap <silent> <leader>y :YRShow<CR>
nnoremap <silent> <leader>y :Yanks<CR>

" YouCompleteMe
nnoremap tg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" EasyMotion
map <SPACE>    <Plug>(easymotion-prefix)
nmap f         <Plug>(easymotion-s2)
xmap f         <Plug>(easymotion-s2)
omap f         <Plug>(easymotion-s2)
nmap <Leader>f <Plug>(easymotion-sn)
xmap <Leader>f <Plug>(easymotion-sn)
omap <Leader>f <Plug>(easymotion-sn)

" Maximizer
noremap <F3> :MaximizerToggle<CR>

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
