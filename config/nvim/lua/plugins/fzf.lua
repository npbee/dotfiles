vim.g.fzf_layout = { window = { width = 0.95, height = 0.95 } }

vim.g.fzf_preview_window = { 'up:50%', 'ctrl-o' }

vim.cmd([[
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('right:55%:hidden', 'ctrl-/'), <bang>0)

]])

-- Like Rg, but raw
vim.cmd([[
command! -bang -nargs=* RG
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.<q-args>, 1,
  \   fzf#vim#with_preview('right:55%:hidden', 'ctrl-/'), <bang>0)
]])
