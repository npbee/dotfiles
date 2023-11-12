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
--
---Specialized root pattern that allows for an exclusion
---@param opt { root: string[], exclude: string[] }
---@return fun(file_name: string): string | nil
M.root_pattern_exclude = function(opt)
  local lsputil = require('lspconfig.util')

  return function(fname)
    local excluded_root = lsputil.root_pattern(opt.exclude)(fname)
    local included_root = lsputil.root_pattern(opt.root)(fname)

    if excluded_root then
      return nil
    else
      return included_root
    end
  end
end

return M
