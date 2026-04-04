vim.loader.enable()

require("settings")
require("plugins")
require("keymappings")
require("autocmds")

vim.cmd([[colorscheme eightyfive]])

local function load_local()
  require("init-local")
end

pcall(load_local)
