local null_ls = require("null-ls")
local null_ls_helpers = require("null-ls.helpers")

local M = {}

-- Custom diagnostics for the `typos` project
-- https://github.com/crate-ci/typos
M.typos_diagnostics = {
  name = "typos",
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = {},
  generator = null_ls.generator({
    command = "typos",
    args = { "--format", "json", "-" },
    to_stdin = true,
    from_stderr = true,
    format = "json_raw",
    check_exit_code = function(code, stderr)
      local success = code <= 1

      if not success then
        -- can be noisy for things that run often (e.g. diagnostics), but can
        -- be useful for things that run on demand (e.g. formatting)
        print(stderr)
      end

      return success
    end,
    -- use helpers to parse the output from string matchers,
    -- or parse it manually with a function
    on_output = function(params)
      local messages = {}

      -- If there is just one message, it comes out as a table
      if type(params.output) == "table" then
        messages = { params.output }
      else
        local json_lines = vim.split(params.output, "\n")
        for k, json_line in pairs(json_lines) do
          if json_line ~= "" then
            line = vim.json.decode(json_line)
            table.insert(messages, line)
          end
        end
      end

      local parser = null_ls_helpers.diagnostics.from_json({
        attributes = {
          row = "line_num",
          col = "byte_offset",
          message = "typo",
          correction = "corrections",
        },
        diagnostic = {
          severity = null_ls_helpers.diagnostics.severities.warning,
        },
      })

      local results = parser({ output = messages })

      for k, v in pairs(results) do
        v.col = v.col + 1
        v.end_col = v.col + string.len(v.message)
        v.message = v.message .. " should be '" .. table.concat(v.correction, " or ") .. "'"
      end

      return results
    end,
  }),
}

return M
