local opt = vim.opt

opt.backup = false
opt.background = "dark"
opt.clipboard = "unnamedplus" --sync with system clipboard
opt.colorcolumn = "80"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 0 -- Hide * markup for bold and italic
opt.expandtab = true -- Use spaces instead of tabs
opt.exrc = true
opt.foldlevelstart = 99
opt.foldmethod = "indent"
opt.history = 200
opt.hlsearch = false
opt.incsearch = true
opt.laststatus = 3
opt.lazyredraw = true
opt.list = true -- show some invisible characters (tabs...)
opt.listchars = "tab:  ,trail:·"
opt.pumblend = 10 -- popup blend
opt.pumwidth = 80
opt.relativenumber = true -- relative  line numbers
opt.scrolloff = 3 -- lines of context
opt.secure = true
opt.shiftwidth = 2 -- size of indent
opt.showmode = false -- False since we have a status line
opt.showcmdloc = "statusline"
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.signcolumn = "yes" -- Always show sign column to avoid layout shift
opt.spell = true
opt.spelllang = "en"
opt.splitbelow = true
opt.synmaxcol = 200
opt.syntax = "on"
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 500
opt.updatetime = 100
opt.wildmenu = true
opt.wildmode = "longest,list:full"
opt.winborder = "rounded"

vim.g.mapleader = " "
vim.g.filetype = "plugin indent on"

-- Term colors for fzf
-- dark0 + gray
vim.g.terminal_color_0 = "#282828"
vim.g.terminal_color_8 = "#928374"

-- red
vim.g.terminal_color_1 = "#cc241d"
vim.g.terminal_color_9 = "#fb4934"

-- green
vim.g.terminal_color_2 = "#98971a"
vim.g.terminal_color_10 = "#b8bb26"

-- neutral_yellow + bright_yellow
vim.g.terminal_color_3 = "#d79921"
vim.g.terminal_color_11 = "#fabd2f"

-- neutral_blue + bright_blue
vim.g.terminal_color_4 = "#458588"
vim.g.terminal_color_12 = "#83a598"

-- neutral_purple + bright_purple
vim.g.terminal_color_5 = "#b16286"
vim.g.terminal_color_13 = "#d3869b"

-- neutral_aqua + faded_aqua
vim.g.terminal_color_6 = "#689d6a"
vim.g.terminal_color_14 = "#8ec07c"

-- light4 + light1
vim.g.terminal_color_7 = "#a89984"
vim.g.terminal_color_15 = "#ebdbb2"
