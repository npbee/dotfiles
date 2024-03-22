local util = require("util")

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
    },
  },

  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "gza", -- Add surrounding in Normal and Visual modes
          delete = "gzd", -- Delete surrounding
          find = "gzf", -- Find surrounding (to the right)
          find_left = "gzF", -- Find surrounding (to the left)
          highlight = "gzh", -- Highlight surrounding
          replace = "gzr", -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`

          suffix_last = "l", -- Suffix to search with "prev" method
          suffix_next = "n", -- Suffix to search with "next" method
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      -- Format command
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })

      -- Disable formatting
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        vim.g.disable_autoformat = true
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      -- Enable formatting
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })

      -- Toggle formatting
      vim.api.nvim_create_user_command("FormatToggle", function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      end, {
        desc = "Re-enable autoformat-on-save",
      })

      -- Show all formatters
      vim.api.nvim_create_user_command("Formatters", function()
        print(vim.inspect(require("conform").list_formatters()))
      end, {
        desc = "Show available formatters",
      })

      require("conform").setup({
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat then
            return
          end

          -- Disable autoformat for files in a certain path
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          if bufname:match("/node_modules/") then
            return
          end

          return { timeout_ms = 500, lsp_fallback = true }
        end,
        formatters_by_ft = {
          css = { "prettierd" },
          html = { "prettierd" },
          lua = { "stylua" },
          javascript = { "prettierd" },
          javascriptreact = { "prettierd" },
          json = { "prettierd" },
          markdown = { "prettierd" },
          scss = { "prettierd" },
          yaml = { "prettierd" },
          prisma = { "prettierd" },
          sh = { "shfmt" },
          typescript = function(bufnr)
            if util.is_deno_project(bufnr) then
              return { "deno_fmt" }
            else
              return { "prettierd" }
            end
          end,
          typescriptreact = function(bufnr)
            if util.is_deno_project(bufnr) then
              return { "deno_fmt" }
            else
              return { "prettierd" }
            end
          end,
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
      { "t<C-f>", ":TestFile<CR>", { silent = true } },
      { "t<C-s>", ":TestSuite<CR>", { silent = true } },
      { "t<C-l>", ":TestLast<CR>", { silent = true } },
      { "t<C-g>", ":TestVisit<CR>", { silent = true } },
    },
  },

  {
    "github/copilot.vim",
  },
}
