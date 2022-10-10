local telescope = require("telescope")
local builtins = require("telescope.builtin")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    -- layout_strategy = "vertical",
    layout_config = {
      horizontal = {
        width_padding = 0.04,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      },
    },
    mappings = {
      i = {
        ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
        ["<esc>"] = actions.close
      }
    },
    preview = {
      hide_on_startup = true
    }
  },
  extensions = {
    ['ui-select'] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  },
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
