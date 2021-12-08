vim.cmd([[
silent! if plug#begin(stdpath('data') . '/plugged')

Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'npbee/eighty-five'
Plug 'mattn/efm-langserver'
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
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/lsp-colors.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'

call plug#end()

endif
]])

require('plugins.fzf')
require('plugins.ale')
require('plugins.cmp')
