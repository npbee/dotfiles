local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { 'nvim-telescope/telescope-ui-select.nvim' }
    },
  })

  -- Colorschemes
  use({ "~/code/eighty-five", requires = "cocopon/inspecthi.vim" })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = "nvim-treesitter/playground",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "javascript", "typescript" },

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- list of language that will be disabled
          -- disable = { "c", "rust" },

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = true,

          indent = { enabled = true },
          incremental_selection = { enable = true }
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
      })
    end,
  })

  use({
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  })


  -- Lush
  use({ "rktjmp/lush.nvim" })

  -- Gitlinker
  use({
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup()
    end,
  })

  -- Dirvish
  use({
    "justinmk/vim-dirvish",
    -- requires = "roginfarrer/vim-dirvish-dovish",
    config = function()
      -- Dirvish: Sort directories at the top
      vim.g.dirvish_mode = ":sort ,^.*[\\/],"
    end,
  })

  -- Polyglot
  use("sheerun/vim-polyglot")

  use({
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  })

  -- Sandwich
  use("machakann/vim-sandwich") -- config below for sandwich mappings

  -- Lightspeed
  use({
    "ggandor/leap.nvim",
    config = function()
      require('leap').set_default_keymaps(true)
    end
  })

  -- Plenary
  use("nvim-lua/plenary.nvim")

  use({
    "L3MON4D3/LuaSnip",
  })

  use("ray-x/lsp_signature.nvim")

  -- Lsp
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp")
    end,
  })

  -- Emmet
  use({
    "mattn/emmet-vim",
    config = function()
      vim.g.user_emmet_leader_key = "<C-E>"
    end,
  })

  -- Vim Test
  use({
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "neoterm"
    end,
  })

  -- Neoterm
  use({
    "kassio/neoterm",
    config = function()
      vim.g.neoterm_default_mod = "vertical"
    end,
  })

  -- LSP Colors
  use("folke/lsp-colors.nvim")

  -- Nvim cmp
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip"
    },
  })

  -- Statusline
  use({
    "famiu/feline.nvim",
  })

  -- Gitsigns
  use({
    "lewis6991/gitsigns.nvim",
  })

  -- Nulli LS
  use("jose-elias-alvarez/null-ls.nvim")

  -- Fzf

  use({
    "junegunn/fzf.vim",
    requires = { {
      "junegunn/fzf",
      run = function()
        fn["fzf#install"]()
      end,
    } },
  })

  -- lightbulb
  use({
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
    end,
  })

  use("evanleck/vim-svelte")

  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  })

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        window = {
          border = "single",
          winblend = 4
        }
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use({
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup()
    end
  })

  use({ 'roginfarrer/vim-dirvish-dovish' })

  use({ "jose-elias-alvarez/typescript.nvim" })

  use({
    "MunifTanjim/exrc.nvim",
    config = function()
      require("exrc").setup({
        files = {
          ".nvimrc.lua",
          ".nvimrc",
          ".exrc.lua",
          ".exrc",
        },
      })
    end
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- Use surround mappings for sandwich
vim.api.nvim_command("runtime macros/sandwich/keymap/surround.vim")
