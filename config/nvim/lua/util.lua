local M = {}

M.is_deno_project = function(bufnr)
  return vim.fs.find({ "deno.json", "deno.jsonc" }, {
    upward = true,
  })[1]
end

---Specialized root pattern that allows for an exclusion
---@param opt { root: string[], exclude: string[] }
---@return fun(file_name: string): string | nil
M.root_pattern_exclude = function(opt)
  local lsputil = require("lspconfig.util")

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
