return {
  {
    "npbee/eighty-five",
    dependencies = { "rktjmp/lush.nvim" },
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd([[colorscheme eighty-five]])
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },


  {
    'echasnovski/mini.surround',
    version = false,
    config = function()
      require('mini.surround').setup({
        mappings = {
          add = "gza",            -- Add surrounding in Normal and Visual modes
          delete = "gzd",         -- Delete surrounding
          find = "gzf",           -- Find surrounding (to the right)
          find_left = "gzF",      -- Find surrounding (to the left)
          highlight = "gzh",      -- Highlight surrounding
          replace = "gzr",        -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`

          suffix_last = 'l',      -- Suffix to search with "prev" method
          suffix_next = 'n',      -- Suffix to search with "next" method
        },
      })
    end
  },

  {
    "elentok/format-on-save.nvim",
    config = function()
      local formatters = require("format-on-save.formatters")

      require("format-on-save").setup({
        -- debug = true,
        exclude_path_patterns = {
          "/node_modules/",
        },
        formatter_by_ft = {
          astro = formatters.lsp,
          css = formatters.prettierd,
          elixir = formatters.lsp,
          html = formatters.prettierd,
          javascript = formatters.prettierd,
          javascriptreact = formatters.prettierd,
          json = formatters.prettierd,
          lua = formatters.lsp,
          markdown = formatters.prettierd,
          scss = formatters.prettierd,
          svelte = formatters.lsp,
          typescriptreact = formatters.prettierd,
          yaml = formatters.prettierd,
          typescript = {
            formatters.if_file_exists({
              pattern = { "package.json" },
              formatter = formatters.prettierd
            }),
            formatters.if_file_exists({
              pattern = { "deno.jsonc", "deno.json" },
              formatter = formatters.lsp,
            }),
          },
          sh = formatters.shfmt,
        },


        fallback_formatter = {
        },

      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
        -- TODO: stylelint
      }
    end,
  },

  {
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
    end,
  },

  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitlinker").setup()
    end,
  },

  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_keymaps(true)
    end,
  },

  {
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
    end,
  },

  {
    "kassio/neoterm",
    config = function()
      vim.g.neoterm_default_mod = "vertical"
    end,
    keys = {
      { "<leader>tx", ":Tclose!<CR>", silent = true },
      { "<leader>tt", ":Ttoggle<CR>", silent = true },
    },
  },

  {
    "justinmk/vim-dirvish",
    config = function()
      -- Dirvish: Sort directories at the top
      vim.g.dirvish_mode = ":sort ,^.*[\\/],"
    end,
  },

  {
    "roginfarrer/vim-dirvish-dovish",
    dependencies = { "justinmk/vim-dirvish" },
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "neoterm"
      vim.g["test#javascript#jest#options"] = "--watch"
    end,
    dependencies = { "kassio/neoterm" },
    keys = {
      { "t<C-n>", ":TestNearest<CR>", { silent = true } },
      { "t<C-f>", ":TestFile<CR>",    { silent = true } },
      { "t<C-s>", ":TestSuite<CR>",   { silent = true } },
      { "t<C-l>", ":TestLast<CR>",    { silent = true } },
      { "t<C-g>", ":TestVisit<CR>",   { silent = true } },
    },
  },

  {
    "github/copilot.vim"
  }
}
