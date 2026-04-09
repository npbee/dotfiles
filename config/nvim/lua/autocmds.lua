vim.api.nvim_create_augroup("no_spell", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    local fname = vim.fn.expand("%:p")
    if fname == "" or vim.bo.buftype ~= "" then return end

    local has_oxlint = vim.fs.find({ "oxlintrc.json", ".oxlintrc.json" }, { path = fname, upward = true })[1]
    local has_eslint = vim.fs.find(
      { "eslint.json", ".eslintrc.json", ".eslintrc.js", ".eslintrc", "eslint.config.mjs", "eslint.config.js" },
      { path = fname, upward = true }
    )[1]

    if has_oxlint and has_eslint then
      require("lint").try_lint({ "oxlint", "eslint_d" })
    elseif has_oxlint then
      require("lint").try_lint("oxlint")
    elseif has_eslint then
      require("lint").try_lint("eslint_d")
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "no_spell",
  pattern = { "dirvish", "json" },
  command = "setlocal nospell",
})

vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  group = "no_spell",
  command = "setlocal nospell",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit" },
  command = "setlocal textwidth=72",
})

vim.api.nvim_create_augroup("statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = "statusline",
  pattern = "*",
  callback = function()
    -- Set the statusline
    vim.o.statusline = "%!v:lua.require('statusline').active()"
  end
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = "statusline",
  pattern = "*",
  callback = function()
    -- Set the statusline
    vim.o.statusline = "%!v:lua.require('statusline').inactive()"
  end
})
