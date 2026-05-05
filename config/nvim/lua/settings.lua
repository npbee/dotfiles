local opt = vim.opt

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

opt.backup = false
opt.background = "dark"
opt.clipboard = "unnamedplus" --sync with system clipboard
opt.colorcolumn = "80"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 0 -- Hide * markup for bold and italic
opt.expandtab = true -- Use spaces instead of tabs
opt.exrc = true
opt.history = 200
opt.laststatus = 3

-- Search
opt.ignorecase = true     -- ignore case when searching...
opt.smartcase = true      -- ...unless there is a capital letter in the query
opt.hlsearch = true       -- highlight all matches on previous search pattern
opt.incsearch = true      -- show the match while typing

opt.iskeyword:append("-") -- consider string-string as whole word

opt.list = true           -- show some invisible characters (tabs...)
opt.listchars = "tab:  ,trail:·"
opt.pumblend = 10         -- popup blend
opt.pumwidth = 80
opt.relativenumber = true -- relative  line numbers
opt.scrolloff = 3         -- lines of context
opt.secure = true
opt.shiftwidth = 2        -- size of indent
opt.showmode = false      -- False since we have a status line
opt.showcmdloc = "statusline"
opt.shortmess:append({ W = true, c = true, C = true })
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

-- Folding
opt.foldmethod = "expr"                          -- fold based on expressions
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- use treesitter for folding
opt.foldlevel = 99                               -- start with all folds open

vim.g.maplocalleader = ' '
vim.g.mapleader = " "
vim.g.filetype = "plugin indent on"

require('vim._core.ui2').enable({})
