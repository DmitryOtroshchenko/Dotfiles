
"
" Helper functions
"

function! Color(active, num, content)
    " This function just outputs the content colored by the
    " supplied colorgroup number, e.g. num = 2 -> User2.
    " It only colors the input if the window is currently active.
    "
    if a:active
        return '%' . a:num . '*' . a:content . '%*'
    else
        return a:content
    endif
endfunction


function! Column()
    " This might seem a bit complicated but all it amounts to is
    " a calculation to see how much padding should be used for the
    " column number, so that it lines up nicely with the line numbers.
    "
    let vc = virtcol('.')
    let ruler_width = max([strlen(line('$')), (&numberwidth - 1)])
    let column_width = strlen(vc)
    let padding = ruler_width - column_width
    let column = ''

    if padding <= 0
        let column .= vc
    else
        " + 1 becuase for some reason vim eats one of the spaces
        let column .= repeat(' ', padding + 2) . vc
    endif

    return column . ' '
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


function! Status(winnum)
    let active = (a:winnum == winnr())
    let bufnum = winbufnr(a:winnum)

    let stat = ''

    " An expression is needed because expressions are evaluated within
    " the context of the window for which the statusline is being prepared
    " this is crucial because the line and virtcol functions otherwise
    " operate on the currently focused window

    " let stat .= '%1*'
    " let stat .= '%*'
    let stat .= Color(active, 1, Column())

    " file name
    let name = bufname(bufnum)

    let stat .= Color(active, 4, active ? ' » ' : ' « ')
    let directory = fnamemodify(name, ':p:h:~')
    let directory = pathshorten(directory)
    let fname = fnamemodify(name, ':p:t')
    let stat .= Color(active, 4, directory . '/')
    let stat .= Color(active, 2, fname)

    " file modified
    let modified = getbufvar(bufnum, '&modified')
    let stat .= Color(active, 2, modified ? ' +' : '')
    let stat .= Color(active, 4, active ? ' « ' : ' » ')

    " read only
    let readonly = getbufvar(bufnum, '&readonly')
    let stat .= Color(active, 2, readonly ? "\u00D7" : '')

    " paste
    let paste = getbufvar(bufnum, '&paste')
    if active && paste
        let stat .= Color(active, 2, 'PASTE')
    endif

    " right side
    let stat .= Color(active, 2, ' %=')

    if active
        " git branch
        if exists('*fugitive#head')
            let head = fugitive#head()

            if empty(head) && exists('*fugitive#detect') && !exists('b:git_dir')
                call fugitive#detect(getcwd())
                let head = fugitive#head()
            endif
        endif

        if !empty(head)
            let stat .= Color(active, 3, " \u2190" . head . ' ')
        endif
    endif

    let nonstandard_traits = []

    let fileencoding = getbufvar(bufnum, '&fileencoding')
    if fileencoding !=? 'utf-8'
        call add(nonstandard_traits, Color(active, 2, fileencoding))
    endif

    let fileformat = getbufvar(bufnum, '&fileformat')
    if fileformat !=? 'unix'
        call add(nonstandard_traits, Color(active, 2, fileformat))
    endif

    if len(nonstandard_traits) > 0
        let stat .= Color(active, 3, ' ⋮ ')
        let stat .= join(nonstandard_traits, Color(active, 3, ' ⋮ '))
        let stat .= Color(active, 3, ' ')
    endif

    return stat
endfunction


function! FileTypeNameMatcher(winnum, params)
    let bufnum = winbufnr(a:winnum)

    " Match filetype.
    let ft = getbufvar(bufnum, '&buftype')
    let ft_filter = get(a:params, 'ft', ft)
    if ft !=? ft_filter
        return 0
    endif

    " Match buffer name.
    let name = bufname(bufnum)
    let name_filter = get(a:params, 'name', name)
    if name !=? name_filter
        return 0
    endif

    return 1
endfunction


function! GundoStatus(winnum)
    return 'Undo tree'
endfunction


function! GundoPreview(winnum)
    return 'Undo state preview'
endfunction


function! HelpStatus(winnum)
    return 'Help'
endfunction


" [matcher, args, statusline]
let s:alternative_statuslines = [
    \ ['FileTypeNameMatcher', {'name': '__Gundo__'}, 'GundoStatus'],
    \ ['FileTypeNameMatcher', {'name': '__Gundo_Preview__'}, 'GundoPreview'],
    \ ['FileTypeNameMatcher', {'ft': 'help'}, 'HelpStatus']
    \ ]

let s:default_status = 'Status'

function! <SID>PickStatus(winnum)
    " This function goes through the lists of alternative statuslines
    " and matches window <winnum> to each of the matchers.
    " It picks the first matching statusline.
    "
    for block in s:alternative_statuslines
        if len(block) != 3
            throw 'statusline formatting error: invalid selector format.'
        endif
        " TODO: check block len.
        let call_str = 'let is_matching = ' . block[0] . '(a:winnum, block[1])'
        execute call_str
        if is_matching
            return block[2]
        endif
    endfor

    " No match found -> use the default statusline.
    return s:default_status
endfunction


function! <SID>RefreshStatus()
    for nr in range(1, winnr('$'))
        try
            let statusline_func = <SID>PickStatus(nr)
        catch
            echomsg 'One of statusline selectors has thrown an exception: \n' . v:exception
            " Fallback to the default statusline in case of errors.
            let statusline_func = s:default_status
        endtry
        " Set the chosen statusline for window <nr>.
        let status_expr = '%!' . statusline_func . '(' . nr . ')'
        call setwinvar(nr, '&statusline', status_expr)
    endfor
endfunction


augroup status
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatus()
augroup END


" Some separators and pipes for those who like whistles and ribbons.
" '⋮', '⁞', '┊', '┆', '│'

hi User1 ctermfg=33  guifg=#268bd2  ctermbg=15 guibg=#fdf6e3
hi User2 ctermfg=125 guifg=#d33682  ctermbg=7  guibg=#d9d3c2
hi User3 ctermfg=64  guifg=#719e07  ctermbg=7  guibg=#d9d3c2
hi User4 ctermfg=37  guifg=#2aa198  ctermbg=7  guibg=#d9d3c2

nnoremap q :source %<CR>
