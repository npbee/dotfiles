local telescope = require("telescope")
local builtins = require("telescope.builtin")

telescope.load_extension("fzf")

local M = {}

-- Searches specifically for the pattern of `prop=` to find usages of a
-- particular prop
M.react_prop_usage = function()
  local word = vim.fn.expand("<cword>") .. "="
  return builtins.grep_string({
    search = word,
  })
end

return M
