local M = {}

---Find the nearest ancestor directory containing any of the given filenames
---@param patterns string[]
---@param path string
---@return string|nil
local function find_root(patterns, path)
  local match = vim.fs.find(patterns, { path = path, upward = true })[1]
  return match and vim.fs.dirname(match) or nil
end

---Specialized root pattern that allows for an exclusion
---@param opt { root: string[], exclude: string[] }
---@return fun(file_name: string): string | nil
M.root_pattern_exclude = function(opt)
  return function(fname)
    local excluded_root = find_root(opt.exclude, fname)
    local included_root = find_root(opt.root, fname)

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
