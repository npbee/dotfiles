require("settings")
require("plugins")
require("colors")
require("keymappings")
require("autocmds")

local function load_local()
  require("init-local")
end

pcall(load_local)
