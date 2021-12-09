" vim: set foldmethod=marker foldlevel=0 nomodeline:

lua require('settings')
lua require('plugins')
lua require('lsp')
lua require('keymappings')
lua require('autocmds')

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


"" ============================================================================
"" LOCAL VIMRC {{{
"" ============================================================================
if filereadable(glob("~/.config/nvim/init.local.vim"))
    source ~/.config/nvim/init.local.vim
endif
" }}}
" ============================================================================
