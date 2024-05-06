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

    -- If both roots are found, return the one closest to the file we're in
    if included_root and excluded_root and string.len(included_root) > string.len(excluded_root) then
      return included_root
    end

    if excluded_root then
      return nil
    else
      return included_root
    end
  end
end

return M
