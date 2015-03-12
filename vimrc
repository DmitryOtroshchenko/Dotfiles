
if has('vim_starting')
    set nocompatible
endif

" {{{ Essential vimrc tools
function! Print(msg, ...)
    " Parse optional arguments.
    let is_msg = 1
    let is_msg = (get(a:000, 0, 1) == 1)

    " Echo to the appropriate destination.
    if !empty(a:msg)
        if is_msg
            echomsg a:msg
        else
            echo a:msg
        endif
    endif
endfunction

function! TrySource(fname, ...)
    " Parse optional arguments.
    let error_msg = get(a:000, 0, '')
    let is_msg = get(a:000, 1, 1) == 1
    let print_stacktrace = get(a:000, 2, 0) == 1

    let fname = expand(a:fname)
    try
        execute 'source ' . a:fname
        return 0
    catch /.*/
        if !empty(error_msg)
            call Print(error_msg, is_msg)
        endif
        if print_stacktrace
            call Print('Error :', is_msg)
            call Print(v:exception, is_msg)
        endif
        return 1
    endtry
endfunction
" }}}

if TrySource('~/.vimrc_base', 'Cannot source vimrc_base, terminating.')
    finish
endif

"{{{ Automatically install vim-plug if absent.
function! s:InstallPlug()
    let plug_script = expand('~/.vim/autoload/plug.vim')
    let plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    if !filereadable(plug_script)
        echomsg 'Installing vim-plug...'
        silent !mkdir -p ~/.vim/autoload

        " Use either wget or curl to download the script.
        silent !command -v curl
        let curl_exists = (v:shell_error == 0)
        silent !command -v wget
        let wget_exists = (v:shell_error == 0)

        if curl_exists
            execute 'silent !curl -fLo ' . plug_script . ' ' . plug_url
        elseif wget_exists
            execute 'silint !wget -O ' plug_script . ' ' . plug_url
        else
            echomsg 'I cannot download plug.vim? Stop using a crap system without wget and curl.'
            finish
        endif
    endif
endfunction

call s:InstallPlug()
"}}}

" Plugin declarations.
try
    call plug#begin('~/.vim/plugged')
catch /.*/
    echomsg 'Cannot load plug. No hands - no plugins.'
    finish
endtry

"{{{ Meta-plugins and libs

" Asynchronous execution library for Vim.
Plug 'Shougo/vimproc', { 'do': 'make' }

" Plugin developer goodies lib.
Plug 'xolox/vim-misc'

" Google lib for plugin development.
Plug 'google/vim-maktaba'

" Plugin developer tools.
Plug 'tpope/vim-scriptease'

" Dot repeat functionality for other plugins.
Plug 'tpope/vim-repeat'

" Async execution.
Plug 'tpope/vim-dispatch'

" Some weird Japanese shit. If only these fags could write docs in English...
Plug 'osyo-manga/shabadou.vim'

"}}}

"{{{ Autocompletion, linters and code navigation

" Autocompletion engine.
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer --system-libclang' }

" Snippet manager.
Plug 'sirver/ultisnips'

" A collection of snippets.
Plug 'honza/vim-snippets'

" Avoid oldfag-style C-xC-uC-p
Plug 'ervandew/supertab'

" Code outliner.
Plug 'majutsushi/tagbar'

" Permits to execute a part of edited file.
Plug 'thinca/vim-quickrun'

" Quickfix errors highlighter.
Plug 'jceb/vim-hier'

" Shows quickfix errors of the current line in the statusline.
Plug 'dannyob/quickfixstatus'

" Async syntax checker.
Plug 'osyo-manga/vim-watchdogs'

"}}}

"{{{ Window management

" Maximize and unmaximize windows.
Plug 'szw/vim-maximizer'

" Delete buffers without closing splits and tabs.
Plug 'moll/vim-bbye'

" Vim-tmux integration.
Plug 'tpope/vim-tbone'

"}}}

"{{{ Misc

Plug 'tpope/vim-eunuch'

" Misc vim goodies.
Plug 'tpope/vim-unimpaired'

" Start screen with a list of recently opened files and bookmarks.
Plug 'mhinz/vim-startify'

" Undo tree visualization
Plug 'sjl/gundo.vim'

"}}}

"{{{ Markdown and ReST

" Vim pandoc integration.
Plug 'vim-pandoc/vim-pandoc'

" Vim syntax for pandoc-markdown dialect.
Plug 'vim-pandoc/vim-pandoc-syntax'

" Open Marked 2 App from vim.
Plug 'itspriddle/vim-marked'

"}}}

"{{{ Unite et al

" Vim list interface.
Plug 'Shougo/unite.vim'

" 2-panel file manager.
Plug 'Shougo/vimfiler.vim'

" A vimscript-only shell implementation.
Plug 'Shougo/vimshell.vim'

" MRU Unite source for files and directories.
Plug 'Shougo/neomru.vim'

"}}}

"{{{ Language plugins

Plug 'hdima/python-syntax'

Plug 'jmcantrell/vim-virtualenv'

Plug 'JuliaLang/julia-vim'

Plug 'tshirtman/vim-cython'

Plug 'ekalinin/Dockerfile.vim'

"}}}

"{{{ Git

" Git ops from vim command line.
Plug 'tpope/vim-fugitive'

" Git history visualization.
Plug 'gregsexton/gitv'

" Mark changed lines by diff signs.
" This plugin creates redraw artefacts in iTerm in insert mode due to
" a vim bug. The bug was fixed in Vim 7.4.427.
" See https://github.com/airblade/vim-gitgutter/issues/155
Plug 'airblade/vim-gitgutter'

"}}}

"{{{ Text editing

" Clipboard management + distinction delete / cut.
Plug 'svermeulen/vim-easyclip'

" Commenter with comment templates for multiple languages.
Plug 'tomtom/tcomment_vim'

" Insert delimiters intelligently.
Plug 'Raimondi/delimitMate'

" A good plugin for code and text tables alignment.
Plug 'junegunn/vim-easy-align'

" Highlights and removes trailing whitespace.
Plug 'csexton/trailertrash.vim'

" Insert Lorems and Ipsums on demand.
Plug 'vim-scripts/loremipsum'

" Surrounding tags/markers/quotes text objects.
Plug 'tpope/vim-surround'

" Abbreviations and word form-aware substitutions.
Plug 'tpope/vim-abolish'

" Equally indented lines block text object.
Plug 'michaeljsmith/vim-indent-object'

"}}}

"{{{ Search and motions

" The best plugin of all times for text navigation.
Plug 'Lokaltog/vim-easymotion'

" Incremental search with Tab-completion and instant highlight of all matches.
Plug 'haya14busa/incsearch.vim'

" Visual star.
Plug 'haya14busa/vim-asterisk'

" Counts number of occurrences when performing search.
Plug 'osyo-manga/vim-anzu'

" Use ack-grep for multi-file searches.
Plug 'mileszs/ack.vim'

" Sublime and Emacs-like multifile search buffer.
Plug 'pelodelfuego/vim-swoop'

"}}}

"{{{ Colorschemes

" A lot of vim colorschemes including solarized.
Plug 'flazz/vim-colorschemes'

Plug 'gosukiwi/vim-atom-dark'

Plug 'AlxHnr/clear_colors'

" Colors nested parentheses in different colors.
Plug 'luochen1990/rainbow'

"}}}

call TrySource('~/Dotfiles/vim-test.vim')

" End of plugin declarations.
call plug#end()


"{{{ Valloric/YouCompleteMe
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_path_to_python_interpreter = "/usr/local/bin/python2.7"

" nnoremap tg :YcmCompleter GoToDefinitionElseDeclaration<CR>
"}}}


"{{{ majutsushi/tagbar
let g:tagbar_autofocus = 1
let g:tagbar_autopreview = 0
let g:tagbar_show_linenumbers = 1
noremap <F6> :TagbarOpenAutoClose<CR>
"}}}


"{{{ sirver/ultisnips
" TODO: the expansion does not work in iTerm.
let g:UltiSnipsExpandTrigger='<c-Space>'
let g:UltiSnipsListSnippets='<c-Tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
"}}}


"{{{ osyo-manga/vim-watchdogs
let g:watchdogs_check_BufWritePost_enable = 0
"}}}


"{{{ sjl/gundo.vim
let g:gundo_preview_bottom = 1
let g:gundo_right = 1
let g:gundo_help = 0
let g:gundo_preview_statusline = 'history preview'
let g:gundo_tree_statusline = 'undo tree'

noremap <F5> :GundoToggle<CR>
"}}}


"{{{ vim-pandoc/vim-pandoc
let g:pandoc#filetypes#handled = ['markdown', 'textile']
let g:pandoc#syntax#codeblocks#embeds#langs = ["python", "bash=sh", "cpp", "c", "julia", "ruby"]
"}}}


"{{{ szw/vim-maximizer
let g:maximizer_set_default_mapping = 0
noremap <C-W><C-,> :MaximizerToggle<CR>
noremap <C-W>,     :MaximizerToggle<CR>
"}}}


"{{{ moll/vim-bbye
noremap <Leader>x :Bdelete<CR>
"}}}


"{{{ vim-pandoc/vim-pandoc-syntax
let g:pandoc#syntax#conceal#blacklist = [
  \ 'titleblock ',
  \ 'image',
  \ 'block',
  \ 'subscript',
  \ 'superscript',
  \ 'strikeout',
  \ 'atx',
  \ 'codeblock_start',
  \ 'codeblock_delim',
  \ 'footnote',
  \ 'definition',
  \ 'list',
  \ 'newline',
  \ 'dashes',
  \ 'ellipses',
  \ 'quotes',
  \ ]
"}}}


"{{{ Setup markdown file
function! s:SetupMarkdownFt()
    setlocal filetype=pandoc
    setlocal syntax=pandoc
    setlocal foldcolumn=0
    setlocal wrap
    " autocmd BufNewFile,BufReadPost,BufWritePost *.md hi Conceal cterm=NONE ctermbg=NONE ctermfg=red gui=NONE guifg=red guibg=NONE
endfunction

augroup vimrc_markdown
    autocmd!
    autocmd BufNewFile,BufReadPost,BufWritePost *.md call s:SetupMarkdownFt()
augroup END " markdown
"}}}


"{{{ Shougo/unite.vim
let g:unite_source_yank_history_save_clipboard = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_limit = 40
let g:unite_winheight = 12
let g:unite_update_time = 100

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

" TODO: use ack?
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

noremap <Leader>b :Unite -no-split -buffer-name=buffers buffer<CR>
noremap <Leader>t :Unite -no-split -buffer-name=fb -input=** -start-insert buffer file_rec/async<CR>
"}}}


"{{{ Did you mean?
" Ask to precise file name if not sure.
" Inspired by 'EinfachToll/DidYouMean'
function! s:DidYouMean()
    " as of Vim 7.4, glob() has an optional parameter to split, but not
    " everybody is using 7.4 yet
    let matching_files = split(glob(expand('%') . '*', 1), '\n')
    if empty(matching_files)
        return
    endif

    let initial_file_name = expand('%:p')
    let empty_buffer_nr = bufnr('%')
    let unite_params = {
        \ 'path': expand('%:p:h'),
        \ 'input': expand('%:t'),
        \ 'start_insert': 1,
        \ 'buffer_name': 'Did you mean..?',
        \ 'immediately': 1,
        \ 'is_async': 1,
        \ 'no_empty': 1,
        \ 'no_split': 1
    \ }
    call unite#start(['file'], unite_params)
    execute ':silent bdelete ' . empty_buffer_nr
endfunction

augroup vimrc_didyoumean
    autocmd!
    autocmd BufNewFile * call s:DidYouMean()
augroup END
"}}}


"{{{ Shougo/vimfiler.vim
let g:vimfiler_as_default_explorer = 1

noremap <F4> :VimFiler -toggle<CR>
"}}}


"{{{ hdima/python-syntax
let python_highlight_all = 1
"}}}


"{{{ airblade/vim-gitgutter
let g:gitgutter_sign_column_always = 1

" This helps to avoid glitches in terminal.
if !has('gui_running')
    set updatetime=1000
endif

" TODO: choose better mappings. Use easymotion prefix?
nmap <leader>ht <Plug>GitGutterPrevHunk
nmap <leader>hT <Plug>GitGutterNextHunk
"}}}


"{{{ svermeulen/vim-easyclip
noremap <silent> <leader>y :Yanks<CR>
map M m$

let g:EasyClipUseSubstituteDefaults = 0
nmap <silent> gs <plug>SubstituteOverMotionMap
nmap gss <plug>SubstituteLine
xmap gs <plug>XEasyClipPaste
"}}}


"{{{ tomtom/tcomment_vim
let g:tcommentMapLeaderOp1='<leader>c'
let g:tcommentMapLeaderUncommentAnyway='<leader><'
let g:tcommentMapLeaderCommentAnyway='<leader>>'
"}}}


"{{{ csexton/trailertrash.vim
highlight UnwantedTrailerTrash guibg=#DA3435 ctermbg=red
let g:trailertrash_blacklist = ['unite']

augroup vimrc_trim_trailing_whitespaces
    autocmd!
    autocmd FileType * autocmd BufWritePre <buffer> :TrailerTrim
augroup END " trim_trailing_whitespace

augroup vimrc_show_hide_trailing_whitespaces
    autocmd!
    autocmd InsertEnter * TrailerHide
    autocmd InsertLeave * TrailerShow
augroup END " trail
"}}}


"{{{ tpope/vim-surround
let g:surround_{char2nr('d')} = '\\text{\r}'
"}}}


"{{{ Lokaltog/vim-easymotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ARSTNEIODHFPLUVMWYQ;CXZBKG'
let g:EasyMotion_do_shade = 1

map <SPACE> <Plug>(easymotion-prefix)

nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap s <Plug>(easymotion-s2)

nmap f <Plug>(easymotion-f)
xmap f <Plug>(easymotion-f)
omap f <Plug>(easymotion-f)

nmap F <Plug>(easymotion-F)
xmap F <Plug>(easymotion-F)
omap F <Plug>(easymotion-F)

nmap t <Plug>(easymotion-t)
xmap t <Plug>(easymotion-t)
omap t <Plug>(easymotion-t)

nmap T <Plug>(easymotion-T)
xmap T <Plug>(easymotion-T)
omap T <Plug>(easymotion-T)

nmap <Plug>(easymotion-prefix)k <Plug>(easymotion-j)
xmap <Plug>(easymotion-prefix)k <Plug>(easymotion-j)
omap <Plug>(easymotion-prefix)k <Plug>(easymotion-j)

nmap <Plug>(easymotion-prefix)h <Plug>(easymotion-k)
xmap <Plug>(easymotion-prefix)h <Plug>(easymotion-k)
omap <Plug>(easymotion-prefix)h <Plug>(easymotion-k)

nmap <Leader>f <Plug>(easymotion-sn)
xmap <Leader>f <Plug>(easymotion-sn)
omap <Leader>f <Plug>(easymotion-sn)

" TODO: what's that?
" noremap <Plug>(easymotion-lineanywhere)
"}}}


"{{{ haya14busa/incsearch.vim
let g:incsearch#consistent_n_direction = 1
let g:incsearch#do_not_save_error_message_history = 1
let g:incsearch#magic = '\v' " very magic
let g:incsearch#smart_backward_word = 1
let g:incsearch#separate_highlight = 1

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-stay)
map g/ <Plug>(incsearch-stay)

function! s:IncsearchKeymap()
    IncSearchNoreMap <Tab>   <Over>(buffer-complete)
    IncSearchNoreMap <S-Tab> <Over>(buffer-complete-prev)
endfunction

augroup vimrc_incsearch_keymap
    autocmd!
    autocmd VimEnter * call s:IncsearchKeymap()
augroup END
"}}}


"{{{ haya14busa/vim-asterisk
" Do not move cursor when searching
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
"}}}


"{{{ osyo-manga/vim-anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
" TODO: why commented?
" nmap * <Plug>(anzu-star-with-echo)
" nmap # <Plug>(anzu-sharp-with-echo)
"}}}


"{{{ mileszs/ack.vim
let g:ack_default_options = ' -s -H --nocolor --nogroup --smart-case --sort-files --follow'
let g:ackhighlight = 1
" let g:ack_autofold_results = 1
let g:ackpreview = 1
let g:ack_use_dispatch = 1
"}}}


"{{{ luochen1990/rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
    \ 'guifgs':   ['#e6dfce', '#b58900', '#d33682', '#859900'] }
    " \ 'ctermfgs': ['Red3', 'cyan', 'DarkOrange', 'green'] }
"}}}


"{{{ Colorscheme tweaks
let g:solarized_contrast = 'normal'
let g:solarized_diffmode = 'normal'
let g:solarized_menu = 0
let g:solarized_hitrail = 1

colorscheme solarized

function! s:UpdateColorscheme()
    " Line number should have the same color as the rest of the workspace.
    highlight LineNr ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
    " Sign column should have the same color as the rest of the workspace.
    highlight SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
    " Fix gitgutter colors: it takes them from uncorrected colorscheme.
    highlight link GitGutterAdd DiffAdd
    highlight link GitGutterChange DiffChange
    highlight link GitGutterDelete DiffDelete
    highlight link GitGutterChangeDelete DiffDelete
endfunction

augroup vimrc_fix_colorscheme
    autocmd!
    autocmd VimEnter,ColorScheme * call s:UpdateColorscheme()
augroup END
"}}}


"{{{ Change cursor color depending on current mode
function! s:SetModeAwareCursors()
    highlight Cursor        guifg=#fdf6e3 guibg=#2aa198
    highlight NormalCursor  guifg=#fdf6e3 guibg=#2aa198 " #5489ce
    highlight InsertCursor  guifg=#fdf6e3 guibg=#b58900 " #8a9824
    highlight VisualCursor  guifg=#fdf6e3 guibg=#d33682
    highlight ReplaceCursor guifg=#fdf6e3 guibg=#dc322f
    highlight CommandCursor guifg=#fdf6e3 guibg=#cb4b16

    " Turn off blinking.
    set guicursor=a:block-Cursor

    " Mode aware cursors.
    set guicursor+=o:hor50-NormalCursor
    set guicursor+=n:NormalCursor
    set guicursor+=i-ci-sm:InsertCursor
    set guicursor+=r-cr:ReplaceCursor-hor20
    set guicursor+=c:InsertCursor
    set guicursor+=v-ve:VisualCursor

    " I said NO blinking!
    set guicursor+=a:blinkon0
endfunction

augroup vimrc_set_mode_aware_cursors
    autocmd!
    autocmd VimEnter,ColorScheme * call s:SetModeAwareCursors()
augroup END
"}}}


augroup vimrc_ft_python
    autocmd!
    " Allow triple quotes.
    autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

let g:virtualenv_auto_activate = 1

call TrySource('~/.vimrc_local')
