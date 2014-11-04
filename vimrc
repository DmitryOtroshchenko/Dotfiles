
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle core
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('vim_starting')
    set nocompatible
    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let vundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
" Install neobundle if not found`
if !filereadable(vundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" In order to avoid this kind of errors when using fish:
" 'E484: Can’t open file /tmp/vRDNVqe/0'
set shell=/bin/bash

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
NeoBundle 'ervandew/supertab'
NeoBundle 'sirver/ultisnips'
NeoBundle 'honza/vim-snippets'

NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neossh.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'gcmt/wildfire.vim'

NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'danro/rename.vim'
NeoBundle 'edkolev/promptline.vim'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'hdima/python-syntax'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'jmcantrell/vim-virtualenv'
NeoBundle 'luochen1990/rainbow'
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
NeoBundle 'jeetsukumaran/vim-markology'
NeoBundle 'mtth/scratch.vim'
NeoBundle 'JuliaLang/julia-vim'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'ervandew/screen'
NeoBundle 'alfredodeza/khuno.vim'
NeoBundle 'haya14busa/incsearch.vim'
" NeoBundle 'dhruvasagar/vim-table-mode'
"NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'xolox/vim-misc'
NeoBundle 'justinmk/vim-gtfo'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'daddye/soda.vim'
" NeoBundle 'godlygeek/csapprox'
" NeoBundle 'carlobaldassi/vim-colorschemedegrade'
" NeoBundle 'calebsmith/vim-lambdify'

NeoBundle 'itspriddle/vim-marked'
NeoBundle 'maxbrunsfeld/vim-yankstack'
NeoBundle 'vim-pandoc/vim-pandoc'
NeoBundle 'vim-pandoc/vim-pandoc-syntax'
NeoBundle 'vim-voom/VOoM'
" NeoBundle 'Rykka/riv.vim'
NeoBundle 'Rykka/InstantRst'
" NeoBundle 'chrisbra/NrrwRgn'
" NeoBundle 'wikimatze/hammer.vim'
" NeoBundle 'wmvanvliet/vim-ipython'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle end
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call neobundle#end()

" Required:
" filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" TODO
call yankstack#setup()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256
set ttyfast
if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

if has("gui_running")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h17
    set linespace=4
    set guioptions=acimgr
endif

if exists("+undofile")
    " undofile - This allows you to use undos after exiting and restarting
    " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
    " Do not forget to create the direectory
    silent !mkdir -p ~/.vim/undo/
    set undodir=~/.vim/undo/
    set undofile
endif

" Colors
syntax on
set background=dark
let g:solarized_contrast="normal"
let g:solarized_diffmode="normal"
let g:solarized_menu=0
colorscheme solarized
" colorscheme Monokai-dmitry

highlight LineNr     ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
highlight SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

set macmeta

" GUI
set showtabline=2
set guicursor+=a:blinkon0
set mousemodel=popup_setpos
" CursorHold event frequency in ms. Used for UI updates.
set updatetime=100

" UI
set title
set showcmd
set showmode

" Splits tabs and sessions
set laststatus=2
set splitbelow
set splitright
" Enable hidden buffers
set hidden
" Do not store global and local values in a session.
set ssop-=options
" Do not store folds.
set ssop-=folds

" Turns off all error bells, visual or otherwise.
set noerrorbells
set visualbell
set t_vb=
" autocmd vimrc GUIEnter * set visualbell t_vb=

" Wildmenu
set wildignorecase
set wildmenu
set wildmode=longest:full,full
set completeopt=menuone
" Ignore
set wildignore=*.log
set wildignore+=*/tmp/*
set wildignore+=.svn,.git,.hg
set wildignore+=*.pyc,*.pyo,__pycache__
set wildignore+=*.o,*.so
set wildignore+=*.swp,*.dump,*.dmp,*.hi,*.zip
set wildignore+=*.db,*.sqlite

" Indentation
set nowrap
set copyindent
set shiftround
set autoindent

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Code folding
set foldmethod=indent
set foldlevel=99

" Navigation
set number
set relativenumber
set numberwidth=5
set cursorline
set nocursorcolumn
set colorcolumn=80,100
set scrolloff=3
set virtualedit=block

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
    autocmd BufNewFile,BufReadPost,BufWritePost *.md set filetype=pandoc
    autocmd BufNewFile,BufReadPost,BufWritePost *.md set syntax=pandoc
    autocmd BufNewFile,BufReadPost,BufWritePost *.md set syntax=pandoc
    autocmd BufNewFile,BufReadPost,BufWritePost *.md hi Conceal cterm=NONE ctermbg=NONE ctermfg=red gui=NONE guifg=red guibg=NONE
augroup END " markdown

augroup text_files
    autocmd!
    autocmd BufNewFile,BufReadPost *.md,*.txt,*.rst set wrap linebreak nolist
augroup END

augroup git_diff
    autocmd!
    " Show Git diff in window split when commiting git diff.
    autocmd FileType gitcommit DiffGitCached | wincmd p
    " Turn on spellcheck.
    autocmd BufRead COMMIT_EDITMSG setlocal spell!
augroup END " git_diff

function! TrimTrailingWS()
    normal mz
    execute '%s/\s\+$//e'
    normal `z
    delmarks z
endfunction

augroup trim_trailing_whitespace
    autocmd!
    autocmd FileType c,cpp,java,php,python,markdown,r,julia,sql,vim autocmd BufWritePre <buffer> :call TrimTrailingWS()
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
      \ 'colorscheme': 'solarized',
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
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'reg': 'winwidth(0) > 70'
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
    let reg_contents = @"
    let reg_contents = ShrinkWS(reg_contents)
    let reg_contents = StripWS(reg_contents)
    let reg_contents = substitute(reg_contents, '\n', '¬ ', '')
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
" Valloric/YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_filepath_completion_use_working_dir = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
" bufkill
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:BufKillCreateMappings = 0

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
" Abbreviations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iabbrev teh the
iabbrev fo of
iabbrev @@ dmitry.otroshchenko@gmail.com

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymap
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=','

set pastetoggle=<F2>
" I can type :help on my own, thanks.
noremap <F1> <Esc>

nnoremap ; :
vnoremap ; :

nnoremap <C-W>w :w<CR>
nnoremap <C-W><C-W> :w<CR>

nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>lcd :lcd %:p:h<CR>

map Y y$
noremap <Leader>A ggVG
nnoremap gp `[v`]

nnoremap <leader>ss :source $MYVIMRC<CR>
nnoremap <leader>se :tabnew $MYVIMRC<CR>

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

"" Tabs
nmap <Tab> gt
nmap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

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

nmap <Leader>h :set hlsearch! hlsearch?<CR>
nmap <Leader>w :set wrap! wrap?<CR>

" Don't loose selection after indenting in visual mode.
vnoremap < <gv
vnoremap > >gv

" Up-down through long lines chunks.
map j gj
map <down> gj
imap <down> <C-o>gj
map k gk
map <up> gk
imap <up> <C-o>gk

" Redo with U
noremap U <C-r>

" Expand currend file path in command mode
cnoremap <C-SPACE> <C-R>=expand("%:p:h") . "/" <CR>
" Sudo write
cmap w!! w !sudo tee % >/dev/null

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin mappings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Unite.vim
nnoremap <Leader>b :Unite -no-split -buffer-name=buffers buffer<CR>
nnoremap <Leader>t :Unite -no-split -buffer-name=fb -input=** -start-insert buffer file_rec/async<CR>

" YankRing and yankstack
" nnoremap <silent> <leader>y :YRShow<CR>
nnoremap <silent> <leader>y :Yanks<CR>

" YouCompleteMe
" nnoremap tg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-Space>"
let g:UltiSnipsListSnippets="<c-Tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

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

nmap <Leader>f <Plug>(easymotion-sn)
xmap <Leader>f <Plug>(easymotion-sn)
omap <Leader>f <Plug>(easymotion-sn)

" Maximizer
noremap <F3>       :MaximizerToggle<CR>
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
noremap <silent> mm :MarkologyPlaceMarkToggle<CR>

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

" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

set langmap=яq,ьw,фf,пp,гg,жj,лl,уu,ыy,ш[,э],аa,рr,сs,тt,дd,хh,нn,еe,иi,оo,зz,чx,цc,вv,бb,кk,мm,ЯQ,ЬW,ФF,ПP,ГG,ЖJ,ЛL,УU,ЫY,Ш[,Э],АA,РR,СS,ТT,ДD,ХH,НN,ЕE,ИI,ОO,ЗZ,ЧX,ЦC,ВV,БB,КK,МM
" from __future__ import division, unicode_literals, print_function
" eng = 'qwfpgjluy[]arstdhneiozxcvbkm'
" ru  = 'яьфпгжлуышэарстдхнеиозчцвбкм'
" langmap_lower = ','.join('{}{}'.format(e, r) for e, r in zip(ru, eng))
" langmap = ','.join((langmap_lower, langmap_lower.upper()))
" print(langmap)

noremap @; @:

" Required:
filetype plugin indent on
