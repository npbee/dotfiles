local function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command("augroup " .. group_name)
    vim.api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command("augroup END")
  end
end

vim.api.nvim_command("augroup main")
vim.api.nvim_command("autocmd!")
vim.api.nvim_command([[
    autocmd FileType fzf
    autocmd FileType fzf set laststatus=0 noshowmode noruler
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
]])
vim.api.nvim_command("augroup END")
