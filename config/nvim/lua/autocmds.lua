local CustomGroup = vim.api.nvim_create_augroup('CustomGroup', { clear = true })

vim.api.nvim_create_augroup("no_spell", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    local denodir = vim.fn.finddir("deno.jsonc", ";" .. vim.fn.expand("%:p"))

    if denodir == nil then
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

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     if vim.fn.argv(0) == "" then
--       require("fzf-lua").files()
--     end
--   end,
-- })
