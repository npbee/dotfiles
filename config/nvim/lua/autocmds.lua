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

local autocmds = {
  startup = {
    { "FileType", "dirvish,json", "setlocal nospell" },
    { "TermOpen,TermEnter", "*", "setlocal nospell" },
    { "Filetype", "gitcommit", "setlocal textwidth=72" },
    { "BufRead,BufEnter", "*.astro", "set filetype=astro" },

    --  JSON5 comments
    -- { "FileType", "json", "syntax match Comment +//.+$+" },
  },
}

nvim_create_augroups(autocmds)

--     " File Types
--     autocmd BufRead,BufNewFile *.md             set filetype=markdown
--     autocmd BufRead,BufNewFile *.mdx            set filetype=markdown.mdx
--     autocmd BufRead,BufNewFile *.ejs,*.EJS      set filetype=html
--     autocmd BufRead,BufNewFile *.conf           set filetype=nginx
--     autocmd BufRead,BufNewFile
--         \ *.eslintrc,*.babelrc,*.jshintrc,*.JSHINTRC,*.jscsrc,*.flow
--         \ set filetype=javascript
--     autocmd BufRead,BufNewFile *Jenkins*        set syntax=groovy
