
if has('vim_starting')
    set nocompatible

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \    },
    \ }

NeoBundle 'Shougo/unite.vim'

let g:unite_source_yank_history_save_clipboard = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_limit=40

if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
        \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')
    " Use pt in unite grep source.
    " https://github.com/monochromegane/the_platinum_searcher
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')
    " Use ack in unite grep source.
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts =
        \ '--no-heading --no-color -k -H'
    let g:unite_source_grep_recursive_opt = ''
endif

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap <Leader>b  :Unite -no-split -start-insert -buffer-name=buffers buffer<CR>
nnoremap <Leader>f  :Unite -no-split -start-insert -buffer-name=files file_rec/async<CR>
" nnoremap <Leader>cm :Unite -no-split -buffer-name=directory -default-action=cd neomru/directory<CR>
" nnoremap <Leader>cd :Unite -no-split -buffer-name=directory -default-action=cd directory_rec/async<CR>
nnoremap <leader>y  :Unite -no-split -buffer-name=yank history/yank<CR>

NeoBundle 'Shougo/neomru.vim'

NeoBundle 'vim-scripts/YankRing.vim'

NeoBundle 'Lokaltog/powerline'
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

NeoBundle 'scrooloose/syntastic'

" let g:syntastic_python_checker_args='--ignore=E501'

NeoBundle 'Valloric/YouCompleteMe', {
    \ 'build' : {
    \      'mac' : './install.sh --clang-completer --system-libclang',
    \      'unix' : './install.sh --clang-completer --system-libclang',
    \     },
    \ }
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1

NeoBundle 'flazz/vim-colorschemes'

" NeoBundle 'vim-scripts/toggle_maximize.vim'
NeoBundle 'szw/vim-maximizer'

NeoBundle 'dhruvasagar/vim-table-mode'
" NeoBundle 'chrisbra/csv.vim'

NeoBundle 'Lokaltog/vim-easymotion'

let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
let g:EasyMotion_do_shade = 1

map <SPACE>  <Plug>(easymotion-prefix)
map <SPACE>s <Plug>(easymotion-s2)

" NeoBundle 'justinmk/vim-sneak'

" TODO:
NeoBundle 'terryma/vim-multiple-cursors'

" TODO:
NeoBundle 'tomtom/tcomment_vim'

" NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets'
" NeoBundle 'tpope/vim-fugitive'

" You can specify revision/branch/tag.
" NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" GUI
set guifont=Source\ Code\ Pro\ for\ Powerline:h16
set guioptions+=Tceimgr
set showtabline=2
set guicursor+=a:blinkon0

" Colors
syntax on
set background=dark
colorscheme Monokai
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
" :highlight Search    ctermfg=235 ctermbg=186 cterm=NONE guifg=#272822 guibg=#e6db74 gui=NONE
" :highlight IncSearch ctermfg=235 ctermbg=186 cterm=NONE guifg=#272822 guibg=#e6db74 gui=NONE

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

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
set cursorline
set nocursorcolumn
set colorcolumn=80

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
set laststatus=2  " Statusline in every window
set splitbelow
set splitright

" Encodings and symbols
set encoding=utf-8
set fileformats=unix,dos,mac

" Misc
set noerrorbells
set nobackup
set nowritebackup
set noswapfile
set autoread
set autowrite
set history=1000
set undolevels=1000

:set backspace=indent,eol,start
if has('mouse')
    set mouse=a
endif

nnoremap ; :

" nmap <C-J> o<Esc>
" nmap <C-K> O<Esc>
" nnoremap <C-J> m`o<Esc>``
" nnoremap <C-K> m`O<Esc>``
nnoremap K i<CR><Esc>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <M-h> <C-w>-
map <M-j> <C-w><
map <M-k> <C-w>>
map <M-l> <C-w>+

map <leader>] :bn<CR>
map <leader>[ :bp<CR>
" map <leader><Bslash> :ls<CR>
map <leader>x :bd<CR>

nmap <silent> <Bslash>/ :nohlsearch<CR>

cmap w!! w !sudo tee % >/dev/null

" Trim trailing whitespaces
autocmd FileType c,cpp,java,php,python,markdown,r,sql autocmd BufWritePre <buffer> :%s/\s\+$//e

autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline
auto InsertEnter * set nocursorline
auto InsertLeave * set cursorline
