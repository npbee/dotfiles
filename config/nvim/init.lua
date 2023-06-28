local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("settings")
require("lazy").setup("plugins", {
  dev = {
    path = "~/code",
    patterns = { "npbee" },
  },
})
require("keymappings")
require("autocmds")

local function load_local()
  require("init-local")
end

pcall(load_local)
