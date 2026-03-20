local util = require("util")

vim.api.nvim_create_augroup("no_spell", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    local fname = vim.fn.expand("%:p")
    if fname == "" or vim.bo.buftype ~= "" then return end
    local lsputil = require("lspconfig.util")

    -- Check for oxlint config
    local oxlint_root = lsputil.root_pattern("oxlintrc.json", ".oxlintrc.json")(fname)

    -- Check for eslint config (excluding deno projects)
    local eslint_root = util.root_pattern_exclude({
      root = { "eslint.json", ".eslintrc.json", ".eslintrc.js", ".eslintrc", "eslint.config.mjs", "eslint.config.js" },
      exclude = { "deno.json", "deno.jsonc" },
    })(fname)

    if oxlint_root then
      if eslint_root then
        require("lint").try_lint({ "oxlint", "eslint_d" })
      else
        require("lint").try_lint("oxlint")
      end
    elseif eslint_root then
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
