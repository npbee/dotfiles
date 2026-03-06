local lazy = require('lazy')

lazy.setup({
  spec = {
    {
      "npbee/eighty-five",
      dependencies = { "rktjmp/lush.nvim" },
      priority = 1000,
      lazy = false,
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
        vim.api.nvim_create_user_command("FormatDisable", function()
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

        require("conform").formatters.shfmt = {
          prepend_args = { "-i", "2" },
          -- The base args are { "-filename", "$FILENAME" } so the final args will be
          -- { "-i", "2", "-filename", "$FILENAME" }
        }

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

            return { timeout_ms = 1000, lsp_fallback = true }
          end,
          formatters_by_ft = {
            css = { "prettierd" },
            html = { "prettierd" },
            -- lua = { "stylua" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            json = { "prettierd" },
            markdown = { "prettierd" },
            scss = { "prettierd" },
            yaml = { "prettierd" },
            prisma = { "prettierd" },
            sh = { "shfmt" },
            elixir = { "mix" },
            python = { "lsp" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" }
          },
        })
      end,
    },

    {
      "mfussenegger/nvim-lint",
      config = function()
        vim.env.ESLINT_D_PPID = vim.fn.getpid()
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
      "ruifm/gitlinker.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("gitlinker").setup({
          callbacks = {
            ["github-emu"] = function(url_data)
              local url = require("gitlinker.hosts").get_github_type_url(url_data)
              return url:gsub("(github%-emu)", "github.com")
            end,
          },
        })
      end,
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
        vim.g["test#strategy"] = "neovim"
        vim.g["test#neovim#term_position"] = "vert"
        vim.g["test#javascript#jest#options"] = "--watch"
      end,
      keys = {
        { "t<C-n>", ":TestNearest<CR>", { silent = true } },
        { "t<C-f>", ":TestFile<CR>",    { silent = true } },
        { "t<C-s>", ":TestSuite<CR>",   { silent = true } },
        { "t<C-l>", ":TestLast<CR>",    { silent = true } },
        { "t<C-g>", ":TestVisit<CR>",   { silent = true } },
      },
    },
    { import = "plugins.fzf" },
    { import = "plugins.cmp" },
    { import = "plugins.lsp" },
    { import = "plugins.snippets" },
    { import = "plugins.treesitter" },

    {
      'nvim-mini/mini.pick',
      version = '*',
      config = function()
        local win_config = function()
          local height = math.floor(0.618 * vim.o.lines)
          local width = math.floor(0.618 * vim.o.columns)
          return {
            anchor = 'NW',
            height = height,
            width = width,
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
          }
        end
        require('mini.pick').setup({
          mappings = {
            move_up = '<C-k>',
            move_down = '<C-j>',
            toggle_preview = '<C-p>',
          },
          window = {
            config = win_config
          }

        })
      end
    },
    {
      'nvim-mini/mini.extra',
      version = '*',
      config = function()
        require('mini.extra').setup()
      end
    },
    { 'nvim-mini/mini.colors', version = '*' },
    {
      'nvim-mini/mini.clue',
      version = '*',
      config = function()
        local miniclue = require('mini.clue')

        require('mini.clue').setup({
          triggers = {
            -- Leader triggers
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },

            -- `[` and `]` keys
            { mode = 'n', keys = '[' },
            { mode = 'n', keys = ']' },

            -- Built-in completion
            { mode = 'i', keys = '<C-x>' },

            -- `g` key
            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },

            -- Marks
            { mode = 'n', keys = "'" },
            { mode = 'x', keys = "'" },
            { mode = 'n', keys = '`' },
            { mode = 'x', keys = '`' },

            -- Registers
            { mode = 'n', keys = '"' },
            { mode = 'x', keys = '"' },
            { mode = 'i', keys = '<C-r>' },
            { mode = 'c', keys = '<C-r>' },

            -- Window commands
            { mode = 'n', keys = '<C-w>' },

            -- `z` key
            { mode = 'n', keys = 'z' },
            { mode = 'x', keys = 'z' },

            -- mini.surround
            { mode = 'n', keys = 's' },
            { mode = 'x', keys = 's' },
          },

          clues = {
            -- Enhance this by adding descriptions for <Leader> mapping groups
            miniclue.gen_clues.square_brackets(),
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),

            -- mini.surround
            { mode = 'n', keys = 'sa', desc = 'Add surrounding' },
            { mode = 'x', keys = 'sa', desc = 'Add surrounding' },
            { mode = 'n', keys = 'sd', desc = 'Delete surrounding' },
            { mode = 'n', keys = 'sf', desc = 'Find right surrounding' },
            { mode = 'n', keys = 'sF', desc = 'Find left surrounding' },
            { mode = 'n', keys = 'sh', desc = 'Highlight surrounding' },
            { mode = 'n', keys = 'sr', desc = 'Replace surrounding' },
            { mode = 'n', keys = 'sn', desc = 'Update n_lines' },
          },

          window = {
            config = {
              width = 50
            },
            delay = 500,
          }
        })
      end
    },
    {
      "nvim-mini/mini.surround",
      version = "*",
      config = function()
        require("mini.surround").setup()
      end,
    },

    { 'github/copilot.vim' },
    { 'fang2hou/blink-copilot' },

    {
      "bezhermoso/tree-sitter-ghostty",
      build = "make nvim_install",
    },


  }
})
