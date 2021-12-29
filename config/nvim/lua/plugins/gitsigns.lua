require("gitsigns").setup({
  signs = {
    add = {
      hl = "GitSignsAdd",
      text = "▍",
      numhl = "GitSignsAddNr",
      linehl = "GitSignsAddLn",
    },
    change = {
      hl = "GitSignsChange",
      text = "▍",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
    delete = {
      hl = "GitSignsDelete",
      text = "▍",
      show_count = true,
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    topdelete = {
      hl = "GitSignsDelete",
      text = "‾",
      show_count = true,
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    changedelete = {
      hl = "GitSignsChange",
      text = "▍",
      show_count = true,
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
  },
  signcolumn = false,
  numhl = false,
  linehl = false,
  word_diff = false,
  preview_config = { border = "rounded" },
})
