require('settings')
require('plugins')
require('colors')
require('lsp')
require('keymappings')
require('autocmds')

vim.cmd([[
function! ToggleFixOnSave()
    if g:ale_fix_on_save
        let g:ale_fix_on_save = 0
    else
        let g:ale_fix_on_save = 1
    endif
endfunction


if filereadable(glob("~/.config/nvim/init.local.vim"))
    source ~/.config/nvim/init.local.vim
endif
    ]])