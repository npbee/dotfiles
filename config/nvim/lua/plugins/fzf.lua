vim.g.fzf_layout = { window = { width = 0.75, height = 0.85 } }

vim.g.fzf_preview_window = { 'right,55%', 'ctrl-o' }

vim.cmd([[
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)
]])

vim.cmd([[
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('right:55%:hidden', 'ctrl-o'), <bang>0)

]])

-- Like Rg, but raw
vim.cmd([[
command! -bang -nargs=* RG
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.<q-args>, 1,
  \   fzf#vim#with_preview('right:55%:hidden', 'ctrl-o'), <bang>0)
]])
