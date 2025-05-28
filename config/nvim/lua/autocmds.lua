local util = require("util")
local statusline = require('statusline')

local CustomGroup = vim.api.nvim_create_augroup("CustomGroup", { clear = true })

vim.api.nvim_create_augroup("no_spell", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    local fname = vim.fn.expand("%:p")

    local root = util.root_pattern_exclude({
      root = { "eslint.json", ".eslintrc.json", ".eslintrc.js", ".eslintrc", "eslint.config.mjs", "eslint.config.js" },
      exclude = { "deno.json", "deno.jsonc" },
    })(fname)

    if root then
      require("lint").try_lint()
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "no_spell",
  pattern = { "dirvish, json" },
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

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     if vim.fn.argv(0) == "" then
--       require("fzf-lua").files()
--     end
--   end,
-- })
