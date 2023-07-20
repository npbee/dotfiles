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
    "elentok/format-on-save.nvim",
    config = function()
      local formatters = require("format-on-save.formatters")

      require("format-on-save").setup({
        exclude_path_patterns = {
          "/node_modules/",
        },
        formatter_by_ft = {
          css = formatters.prettierd,
          html = formatters.prettierd,
          javascript = formatters.prettierd,
          javascriptreact = formatters.prettierd,
          json = formatters.prettierd,
          lua = formatters.lsp,
          markdown = formatters.prettierd,
          scss = formatters.prettierd,
          svelte = formatters.lsp,
          typescript = formatters.prettierd,
          typescriptreact = formatters.prettierd,
          yaml = formatters.prettierd,
        },

        fallback_formatter = {
          formatters.prettierd,
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

  { "jose-elias-alvarez/typescript.nvim" },

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
}
