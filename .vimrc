
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'ZoomWin'
Plugin 'Lokaltog/powerline'
Plugin 'fugitive.vim'
Plugin 'ack.vim'
Plugin 'The-NERD-tree'
Bundle 'jistr/vim-nerdtree-tabs'
Plugin 'The-NERD-Commenter'
Plugin 'Command-T'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Bundle 'kien/ctrlp.vim'

" Color Themes
Bundle 'flazz/vim-colorschemes'

Bundle 'Valloric/YouCompleteMe'
Bundle 'joonty/vdebug.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on

set background=dark
colorscheme Monokai

filetype indent plugin on

set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4
set shiftround
set autoindent

" Trim trailing whitespaces
autocmd FileType c,cpp,java,php,python,markdown autocmd BufWritePre <buffer> :%s/\s\+$//e

set foldmethod=indent
set foldlevel=99

:set backspace=indent,eol,start

set number
:highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

set encoding=utf-8
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERD Tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let NERDChristmasTree=1
" let NERDTreeAutoCenter=1
" let NERDTreeCaseSensitiveSort=0
let NERDTreeChDirMode=2
" let NERDTreeHighlightCursorline=1
" let NERDTreeHijackNetrw=1
" let NERDTreeIgnore=???
" let NERDTreeBookmarksFile=???
let NERDTreeMouseMode=2 
" let NERDTreeQuitOnOpen=0
let NERDTreeShowBookmarks=1
" let NERDTreeShowFiles=1
" let NERDTreeShowHidden=0
" let NERDTreeShowLineNumbers=0
" let NERDTreeSortOrder=???
" let NERDTreeStatusline=-1
" let NERDTreeWinPos="left"
let NERDTreeWinSize=31
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" map <leader>a :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree-tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:nerdtree_tabs_open_on_gui_startup = 1
" let g:nerdtree_tabs_open_on_console_startup = 0
" let g:nerdtree_tabs_no_startup_for_diff = 1
" let g:nerdtree_tabs_smart_startup_focus = 1
" let g:nerdtree_tabs_open_on_new_tab = 1
" let g:nerdtree_tabs_meaningful_tab_names = 1
" let g:nerdtree_tabs_autoclose = 1
" let g:nerdtree_tabs_synchronize_view = 1
" let g:nerdtree_tabs_synchronize_focus = 1
" let g:nerdtree_tabs_focus_on_files = 0
" g:nerdtree_tabs_startup_cd = 1

map <leader>a :NERDTreeMirrorToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ZoomWin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>f :call ZoomWin()<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

