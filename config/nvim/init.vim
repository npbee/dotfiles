" vim: set foldmethod=marker foldlevel=0 nomodeline:

lua require('plugins')
lua require('lsp')

" Dirvish
" -------

" Sort directories at the top
let g:dirvish_mode = ':sort ,^.*[\/],'

" vim-test
" --------
let test#strategy = "neoterm"

" neoterm
" --------
let g:neoterm_default_mod = "vertical"

" vsnip
" ------
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript', 'javascript']
let g:vsnip_filetypes.typescript = ['typescript', 'javascript']

" emmet-vim
" ----------
let g:user_emmet_leader_key='<C-E>'



" }}}
" ============================================================================

lua require('settings')

"" ============================================================================
"" INIT {{{
"" ============================================================================

augroup vimrc
    autocmd!
augroup END

set statusline=%!StatusLine()

" }}}
" ============================================================================

lua require('keymappings')

"" ============================================================================
"" AUTOCMD {{{
"" ============================================================================
augroup vimrc
    autocmd!
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

    " File Types
    autocmd BufRead,BufNewFile *.md             set filetype=markdown
    autocmd BufRead,BufNewFile *.mdx            set filetype=markdown.mdx
    autocmd BufRead,BufNewFile *.ejs,*.EJS      set filetype=html
    autocmd BufRead,BufNewFile *.conf           set filetype=nginx
    autocmd BufRead,BufNewFile
        \ *.eslintrc,*.babelrc,*.jshintrc,*.JSHINTRC,*.jscsrc,*.flow
        \ set filetype=javascript
    autocmd BufRead,BufNewFile *Jenkins*        set syntax=groovy

    " JSON5
    autocmd FileType json syntax match Comment +\/\/.\+$+

    autocmd Filetype gitcommit setlocal textwidth=72

    au FileType javascript,javascriptreact imap ;; => 
augroup END

" }}}
" ============================================================================

" ============================================================================
" FUNCTIONS {{{
" ============================================================================
" Toggle fixing on saving for ales
function! ToggleFixOnSave()
    if g:ale_fix_on_save
        let g:ale_fix_on_save = 0
    else
        let g:ale_fix_on_save = 1
    endif
endfunction


" }}}
" ============================================================================

" ============================================================================
" FUNCTIONS {{{
" ============================================================================
function! AleStatus(type) abort
  let l:count = ale#statusline#Count(bufnr(''))
  let l:errors = l:count.error + l:count.style_error
  let l:warnings = l:count.warning + l:count.style_warning

  if a:type ==? 'error' && l:errors
    return '  ' . printf(' %d E ', l:errors)
  endif

  if a:type ==? 'warning' && l:warnings
    let l:space = l:errors ? ' ': ''
    return printf('%s %d W ', l:space, l:warnings)
  endif

  return ''
endfunction

function! StatusLine()
 let l:fixing = g:ale_fix_on_save
 let statusl =  '%2* %f %*|%*'                         " File path
 let statusl .= '%4* %y %*|%*'                         " File type

 if l:fixing == 1
   let statusl .=' %3*  %*|%*'                        " Prettier indicator
 endif

  let statusl .= '%2* %m'                               " Modified indicator
  let statusl .= '%='                                   " Start right side
  let statusl .= '%2* %c %*|%*'                         " Column number
  let statusl .= '%2* %l/%L %*|%*'                      " Current Line number / total lines
  let statusl .= "%*%#Error#%{AleStatus('error')}%*" 

   return statusl
endfunction

" }}}
" ============================================================================


"" ============================================================================
"" LOCAL VIMRC {{{
"" ============================================================================
if filereadable(glob("~/.config/nvim/init.local.vim"))
    source ~/.config/nvim/init.local.vim
endif
" }}}
" ============================================================================
