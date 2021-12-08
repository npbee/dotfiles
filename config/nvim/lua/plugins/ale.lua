vim.g.ale_linters = {javascript = {}, css = {"stylelint"}}
vim.g.ale_echo_msg_format = '%linter%: %s [%severity%%/code%]'
vim.g.ale_fixers = {lua = {'lua-format'}}
vim.g.ale_fix_on_save = 1
