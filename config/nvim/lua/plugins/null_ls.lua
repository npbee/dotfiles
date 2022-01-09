local null_ls = require("null-ls")
local null_ls_helpers = require("null-ls.helpers")

local M = {}

local parse_typo_output = function(output)
  local messages = {}
  -- If there is just one message, it comes out as a table
  if type(output) == "table" then
    messages = { output }
  else
    local json_lines = vim.split(output, "\n")
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
      corrections = "corrections",
    },
    diagnostic = {
      severity = null_ls_helpers.diagnostics.severities.warning,
    },
  })

  return parser({ output = messages })
end

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
      local results = parse_typo_output(params.output)

      for k, result in pairs(results) do
        result.col = result.col + 1
        result.end_col = result.col + string.len(result.message)
        correction = result.corrections[1]
        result.message = "'" .. result.message .. "' should be '" .. correction .. "'"
      end

      return results
    end,
  }),
}

M.typos_code_actions = {
  name = "typos",
  method = null_ls.methods.CODE_ACTION,
  filetypes = {},
  generator = null_ls.generator({
    command = "typos",
    args = { "--format", "json", "-" },
    to_stdin = true,
    from_stderr = true,
    format = "json_raw",
    on_output = function(params)
      local results = parse_typo_output(params.output)

      local actions = {}

      for k, result in pairs(results) do
        local correction = result.corrections[1]
        end_col = result.col + string.len(correction)

        table.insert(actions, {
          title = "Change '" .. result.message .. "' to '" .. correction .. "'",
          action = function()
            vim.api.nvim_buf_set_text(
              params.bufnr,
              -- start row
              result.row - 1,
              -- start col
              result.col,
              -- end row
              result.row - 1,
              -- end col
              end_col,
              {
                correction,
              }
            )
          end,
        })
      end

      return actions
    end,
  }),
}

return M
