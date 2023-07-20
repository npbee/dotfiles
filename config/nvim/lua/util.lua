local M = {}

local state = {
  formatting_on_save = true,
}

M.toggle_formatting = function()
  local format_on_save = require('format-on-save')
  local is_enabled = require('format-on-save.config').enabled;

  if is_enabled then
    format_on_save.disable()
  else
    format_on_save.enable()
  end
end

-- Assume we're always formatting all sources or none
M.is_formatting = function()
  return state.formatting_on_save == true
end

return M
