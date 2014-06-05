
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

NeoBundle 'Valloric/YouCompleteMe', {
    \ 'build' : {
    \      'mac' : './install.sh --clang-completer --system-libclang',
    \      'unix' : './install.sh --clang-completer --system-libclang',
    \     },
    \ }

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neossh.vim'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'edkolev/promptline.vim'

NeoBundle 'suan/vim-instant-markdown'
NeoBundle 'osyo-manga/vim-over'
nnoremap g/r :<c-u>OverCommandLine<cr>%s/
xnoremap g/r :<c-u>OverCommandLine<cr>%s/\%V

NeoBundle 'scrooloose/syntastic'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'szw/vim-maximizer'
NeoBundle 'dhruvasagar/vim-table-mode'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'chrisbra/NrrwRgn'
NeoBundle 'sjl/gundo.vim/'
NeoBundle 'ervandew/supertab'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'mhinz/vim-startify'
NeoBundle 'rking/ag.vim'
NeoBundle 'hdima/python-syntax'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'wmvanvliet/vim-ipython'
NeoBundle 'vim-scripts/loremipsum'
" NeoBundle 'mbbill/undotree'
" NeoBundle 'chrisbra/histwin.vim'
" NeoBundle 'davidhalter/jedi-vim'
" NeoBundle 'moll/vim-bbye'
" NeoBundle 'mattdbridges/bufkill.vim'

" NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets'
" NeoBundle 'tpope/vim-fugitive'

" You can specify revision/branch/tag.
" NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" </NeoBundle>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

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

set pastetoggle=<F2>

" GUI
set showtabline=2
set guicursor+=a:blinkon0
set mousemodel=popup_setpos
" Turns off all error bells, visual or otherwise.
set noerrorbells
set visualbell
set t_vb=
" autocmd vimrc GUIEnter * set visualbell t_vb=

" Colors
syntax on
set background=dark
colorscheme Monokai
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
" :highlight Search    ctermfg=235 ctermbg=186 cterm=NONE guifg=#272822 guibg=#e6db74 gui=NONE
" :highlight IncSearch ctermfg=235 ctermbg=186 cterm=NONE guifg=#272822 guibg=#e6db74 gui=NONE

if v:version >= 704
  " The new Vim regex engine is currently slooooow as hell which makes syntax
  " highlighting slow, which introduces typing latency.
  " Consider removing this in the future when the new regex engine becomes
  " faster.
  set regexpengine=1
endif

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

set gdefault
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" UI
set title
set showcmd
set showmode

" Splits tabs and sessions
set laststatus=2
set splitbelow
set splitright

" Encodings and symbols
set encoding=utf-8
set fileformats=unix,dos,mac
set list
set listchars=tab:▸⋅,nbsp:⋅,trail:⋅,eol:¬,extends:❯,precedes:❮

" Misc
set clipboard=unnamed
set confirm
set noerrorbells
set nobackup
set nowritebackup
set noswapfile
set autoread
set autowrite
set history=1000
set undolevels=1000

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

" I can type :help on my own, thanks.
noremap <F1> <Esc>
inoremap jk <Esc>
inoremap kj <Esc>

set backspace=indent,eol,start
if has('mouse')
    set mouse=a
endif

nnoremap ; :
vnoremap ; :

nnoremap ,cd :cd %:p:h<CR>

map Y y$

" TODO:
" Bind :set wrap linebreak nolist

nnoremap <leader>ss :source $MYVIMRC<CR>
nnoremap <leader>se :split  $MYVIMRC<CR>

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

if has("mac")
    map ˙ :vertical resize -5<CR>
    map ∆ :resize +5<CR>
    map ˚ :resize -5<CR>
    map ¬ :vertical resize +5<CR>
else
    map <M-h> :vertical resize -5<CR>
    map <M-j> :resize +5<CR>
    map <M-k> :resize -5<CR>
    map <M-l> :vertical resize +5<CR>
endif

map <leader>] :bn<CR>
map <leader>[ :bp<CR>
map <leader>x :bd<CR>

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
" autocmd
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
let g:unite_source_history_yank_limit=40
let g:unite_winheight=12

" if executable('ag')
"     " Use ag in unite grep source.
"     let g:unite_source_grep_command = 'ag'
"     let g:unite_source_grep_default_opts =
"         \ '--nocolor --nogroup --hidden --ignore ' .
"         \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
"     let g:unite_source_grep_recursive_opt = ''
" elseif executable('pt')
"     " Use pt in unite grep source.
"     " https://github.com/monochromegane/the_platinum_searcher
"     let g:unite_source_grep_command = 'pt'
"     let g:unite_source_grep_default_opts = '--nogroup --nocolor'
"     let g:unite_source_grep_recursive_opt = ''
" elseif executable('ack-grep')
"     " Use ack in unite grep source.
"     let g:unite_source_grep_command = 'ack-grep'
"     let g:unite_source_grep_default_opts =
"         \ '--no-heading --no-color -k -H'
"     let g:unite_source_grep_recursive_opt = ''
" endif

nnoremap <Leader>b  :Unite -no-split -buffer-name=buffers buffer<CR>
nnoremap <Leader>t  :Unite -no-split -buffer-name=fb buffer file_rec/async<CR>
" nnoremap <Leader>gg :Unite -no-split -auto-preview -buffer-name=grep grep:.<CR>
" nnoremap <Leader>gb :Unite -no-split -auto-preview -buffer-name=grep grep:$buffers<CR>
" nnoremap <Leader>cm :Unite -no-split -buffer-name=directory -default-action=cd neomru/directory<CR>
" nnoremap <Leader>cd :Unite -no-split -buffer-name=directory -default-action=cd directory_rec/async<CR>
" nnoremap <leader>y  :Unite -no-split -buffer-name=yank history/yank<CR>

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

nnoremap <silent> <leader>y :YRShow<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Valloric/YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1

nnoremap tg :YcmCompleter GoToDefinitionElseDeclaration<CR>

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

map <SPACE>    <Plug>(easymotion-prefix)

nmap f         <Plug>(easymotion-s2)
xmap f         <Plug>(easymotion-s2)
omap f         <Plug>(easymotion-s2)
nmap <Leader>f <Plug>(easymotion-sn)
xmap <Leader>f <Plug>(easymotion-sn)
omap <Leader>f <Plug>(easymotion-sn)

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

nnoremap <F6> :TagbarOpenAutoClose<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gundo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gundo_preview_bottom = 1
let g:gundo_right = 1
let g:gundo_help = 0
let g:gundo_preview_statusline = 'history preview'
let g:gundo_tree_statusline = 'undo tree'

noremap <F5> :GundoToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:syntastic_python_checkers = ['python', 'pylama', 'py3kwarn']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimfiler
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vimfiler_as_default_explorer = 1

nnoremap <F3> :VimFiler -toggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python-syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let python_highlight_all = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iabbrev @@ dmitry.otroshchenko@gmail.com
" iabbrev @me Dmitry Otroshchenko

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Notes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use :sort with visual selection to sort lines.
" Prompt reload if modified
" Markdown + preview
" SHIFT-H|M|L - navigate screen
" SHIFT-x - back delete
" Folds and bookmarks
" Python rope with configurable path to virtualenvs
" Leader-B for breakpoint
" Go to definition
" Better alternative for rainbow parentheses
" :help!
" map <Leader>a ggVG
"
" Move all backups to ~
" set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"
" Keep search pattern in the center of the screen.
" nnoremap <silent> n nzz
" nnoremap <silent> N Nzz
" nnoremap <silent> * *zz
" nnoremap <silent> # #zz
" nnoremap <silent> g* g*zz
" nnoremap <silent> g# g#zz
"
" Move line up/down | insert newline up/down -- tpope's unimpaired
"
" Add spellcheck
"
" Text objects -> read docs
