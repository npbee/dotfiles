return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
    "ray-x/cmp-treesitter",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    local source_mapping = {
      nvim_lsp = "[LSP]",
      nvim_lua = "[LUA]",
      luasnip = "[SNIP]",
      buffer = "[BUF]",
      path = "[PATH]",
      treesitter = "[TREE]",
      cmp_ai = "[AI]",
      ["vim-dadbod-completion"] = "[DB]",
    }

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),

        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "luasnip", group_index = 1 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "path", group_index = 3 },
        { name = "treesitter", keyword_length = 4, group_index = 4 },
        { name = "buffer", keyword_length = 5, group_index = 4 },
      }),

      window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
      },

      performance = {
        async_budget = 10,
      },

      formatting = {
        format = lspkind.cmp_format({
          mode = "text",
          ellipsis_char = "...",
          menu = source_mapping,
        }),
      },

      experimental = {
        native_menu = false,
        ghost_text = false,
      },
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      mapping = cmp.mapping.preset.cmdline({
        -- Your configuration here.
      }),
    })
  end,
}
