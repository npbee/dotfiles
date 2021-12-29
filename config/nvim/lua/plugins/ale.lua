vim.g.ale_linters = {
  javascript = {},
  javascriptreact = {},
  css = { "stylelint" },
  typescript = {},
  typescriptreact = {},
}
vim.g.ale_echo_msg_format = "%linter%: %s [%severity%%/code%]"
vim.g.ale_fixers = {}
vim.g.ale_fix_on_save = 1
