local null_ls = require("null-ls")

local M = {}

local state = {
  formatting_on_save = true
}

local get_format_sources = function()
  return null_ls.get_source({
    method = null_ls.methods.FORMATTING,
  })
end

M.toggle_formatting = function()
  state.formatting_on_save = not state.formatting_on_save
  require('feline').reset_highlights()
end

-- Assume we're always formatting all sources or none
M.is_formatting = function()
  return state.formatting_on_save == true
end

return M
