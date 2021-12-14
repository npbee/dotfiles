local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'justinmk/vim-dirvish'
    use 'npbee/eighty-five'
    use 'sheerun/vim-polyglot'
    use 'tpope/vim-commentary'
    use 'machakann/vim-sandwich'
    use 'ludovicchabant/vim-gutentags'
    use 'dense-analysis/ale'
    use 'nvim-lua/plenary.nvim'
    use {'hrsh7th/vim-vsnip', requires = {'hrsh7th/vim-vsnip-integ'}}
    use 'neovim/nvim-lspconfig'
    use 'mattn/emmet-vim'
    use 'vim-test/vim-test'
    use 'kassio/neoterm'
    use 'folke/lsp-colors.nvim'
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-vsnip'
        }

    }
    use 'famiu/feline.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'

    use {
        'junegunn/fzf.vim',
        requires = {{'junegunn/fzf', run = function() fn['fzf#install']() end}}
    }

    if packer_bootstrap then require('packer').sync() end
end)

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
