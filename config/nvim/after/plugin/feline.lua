local colors = {
  bg = "#353331",
  fg = "#e4d2a6",
  section_bg = "#42403d",
  blue = "#7e9b8f",
  green = "#93c19a",
  purple = "#b98895",
  orange = "#d89a76",
  red = "#e25c5c",
  yellow = "#d3b471",
  darkgrey = "#2c323d",
  middlegrey = "#bfbcba",
}

local vi_mode_colors = {
  NORMAL = "green",
  OP = "red",
  INSERT = "blue",
  VISUAL = "purple",
  LINES = "purple",
  BLOCK = "purple",
  REPLACE = "red",
  ["V-REPLACE"] = "purple",
  ENTER = "blue",
  MORE = "blue",
  SELECT = "orange",
  COMMAND = "green",
  SHELL = "green",
  TERM = "blue",
  NONE = "yellow",
}

local file_info = {
  provider = {
    name = "file_info",
    opts = {
      file_readonly_icon = "  ",
      file_modified_icon = "•",
      type = "relative",
    },
  },
  icon = "",
  hl = { fg = "fg", bg = "section_bg", style = "bold" },
}

local file_info_inactive = {
  provider = {
    name = "file_info",
    opts = {
      file_readonly_icon = "  ",
      file_modified_icon = "•",
      type = "relative",
    },
  },
  icon = "",
  hl = { fg = "fg", bg = "bg" },
}

local file_type = {
  provider = function()
    return vim.bo.filetype
  end,
  hl = { fg = "purple" },
  left_sep = " ",
}

local git_diff_added = {
  provider = "git_diff_added",
  icon = "+",
  hl = { fg = "green", bg = "bg" },
  left_sep = " ",
}

local git_diff_changed = {
  provider = "git_diff_changed",
  icon = "~",
  hl = { fg = "orange", bg = "bg" },
  left_sep = " ",
}

local git_diff_removed = {
  provider = "git_diff_removed",
  icon = "-",
  hl = { fg = "red", bg = "bg" },
  left_sep = " ",
}

local git_branch = {
  provider = "git_branch",
  left_sep = { " ", { str = " ", hl = { bg = "section_bg" } } },
  right_sep = { { str = " ", hl = { bg = "section_bg" } } },
  hl = { fg = "middlegrey", bg = "section_bg" },
}

local file_position = {
  provider = "position",
  left_sep = { " ", { str = "vertical_bar", hl = { fg = "section_bg" } }, " " },
  hl = { fg = "blue", bg = "bg" },
}

local line_percentage = {
  provider = "line_percentage",
  right_sep = " ",
  hl = { fg = "blue", bg = "bg" },
}

local function get_diagnostic_count(severity)
  local count = #vim.diagnostic.get(0, { severity = severity })
  return count ~= 0 and count .. " " or ""
end

local lsp_errors = {
  provider = function()
    return get_diagnostic_count(vim.diagnostic.severity.ERROR)
  end,
  hl = { fg = "red", bg = "bg" },
}

local lsp_warnings = {
  provider = function()
    return get_diagnostic_count(vim.diagnostic.severity.WARN)
  end,
  hl = { fg = "orange", bg = "bg" },
}

local lsp_info = {
  provider = function()
    return get_diagnostic_count(vim.diagnostic.severity.INFO)
  end,
  hl = { fg = "blue", bg = "bg" },
}

local lsp_name = {
  provider = "lsp_client_names",
  hl = { fg = "yellow" },
  right_sep = " ",
}

local is_formatting = {
  provider = "☭",
  left_sep = { " ", { str = "left_rounded", hl = { fg = "purple" } } },
  right_sep = { { str = "right_rounded", hl = { fg = "purple" } }, " " },
  enabled = function()
    return require("util").is_formatting()
  end,
  hl = { fg = "bg", bg = "purple" },
}

local components = { active = {}, inactive = {} }

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], file_info)
table.insert(components.active[1], file_type)
table.insert(components.active[1], is_formatting)
table.insert(components.active[1], {
  hl = { bg = "bg", fg = "bg" }
})

table.insert(components.active[3], lsp_errors)
table.insert(components.active[3], lsp_warnings)
table.insert(components.active[3], lsp_info)
table.insert(components.active[3], lsp_name)
table.insert(components.active[3], git_diff_added)
table.insert(components.active[3], git_diff_changed)
table.insert(components.active[3], git_diff_removed)
table.insert(components.active[3], file_position)
table.insert(components.active[3], line_percentage)
table.insert(components.active[3], git_branch)

table.insert(components.inactive[1], file_info_inactive)

require("feline").setup({
  components = components,
  theme = colors,
  vi_mode_colors = vi_mode_colors,
})
