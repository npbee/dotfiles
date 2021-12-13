vim.cmd([[
silent! if plug#begin(stdpath('data') . '/plugged')

Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'npbee/eighty-five'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'ludovicchabant/vim-gutentags'
Plug 'dense-analysis/ale'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'neovim/nvim-lspconfig'
Plug 'mattn/emmet-vim'
Plug 'vim-test/vim-test'
Plug 'kassio/neoterm'
Plug 'folke/lsp-colors.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'

Plug 'nvim-lua/plenary.nvim'
Plug 'famiu/feline.nvim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'jose-elias-alvarez/null-ls.nvim'

call plug#end()

endif
]])

require('plugins.fzf')
require('plugins.ale')
require('plugins.cmp')
require('plugins.vsnip')
require('plugins.statusline')
require('plugins.gitsigns')
require('plugins.null-ls')

-- Dirvish: Sort directories at the top
vim.g.dirvish_mode = ":sort ,^.*[\\/],"

-- Vim test
vim.g['test#strategy'] = "neoterm"

-- neoterm
vim.g.neoterm_default_mod = "vertical"

-- Emmet
vim.g.user_emmet_leader_key = '<C-E>'
