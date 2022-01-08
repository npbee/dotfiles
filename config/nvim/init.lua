require("settings")
require("plugins")
require("colors")
require("keymappings")
require("autocmds")

function load_local()
  require("init-local")
end

pcall(load_local)
