function! FileModes()
    let fm = '%2*'

    if &modified
        let fm.= ' +'
    endif

    if &paste
        let fm.= ' P'
    endif

    let fm.= '%1*'

    return fm
endfunction

function! LeftSide()
    let ls = ''
    let ls.='%1* %f '
    let ls.=FileModes()

    return ls
endfunction

function! RightSide()
    let rs = ''

    " if exists ("neomake#statusline#LoclistStatus")
        let errors = neomake#statusline#LoclistStatus()
        if errors =~ 'E'
            let rs .= "%2*"
            let rs .= errors
        else
            let rs .= "%1*"
            let rs .= errors
        endif
        let rs .= "%1*"
        let rs .= " "
    " endif

    if exists('*fugitive#head')
        let head = fugitive#head()

        if !empty(head)
            let rs .= '%3* ' . ' ' . head . ' '
        endif
    endif

    return rs
endfunction

function! StatusLine()
    let statusl = LeftSide()
    let statusl.= '%='
    let statusl.= RightSide()

    return statusl
endfunction

set statusline=%!StatusLine()
