
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
Plugin 'The-NERD-tree'
Plugin 'The-NERD-Commenter'
Plugin 'Lokaltog/powerline'

Bundle 'Valloric/YouCompleteMe'
Bundle 'Solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" /Vundle 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on

set background=dark
colorscheme default

filetype indent plugin on

set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4
set shiftround
set autoindent

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
" let NERDTreeStatusline=???
" let NERDTreeWinPos="left"
let NERDTreeWinSize=31
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

autocmd VimEnter * NERDTree | wincmd p
