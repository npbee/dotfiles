local null_ls = require("null-ls")

local M = {}

local get_format_sources = function()
  return null_ls.get_source({
    method = null_ls.methods.FORMATTING,
  })
end

M.toggle_formatting = function()
  null_ls.toggle(get_format_sources())
end

-- Assume we're always formatting all sources or none
M.is_formatting = function()
  formats = get_format_sources()

  if formats[1]._disabled and formats[1]._disabled == true then
    return false
  else
    return true
  end
end

return M
