local telescope = require("telescope")
local builtins = require("telescope.builtin")

telescope.setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.75
    }
  },
  extensions = {
    ['ui-select'] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")


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
