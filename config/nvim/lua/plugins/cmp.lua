local source_mapping = {
  lsp = "[LSP]",
  nvim_lua = "[LUA]",
  luasnip = "[SNIP]",
  buffer = "[BUF]",
  path = "[PATH]",
  treesitter = "[TREE]",
  cmp_ai = "[AI]",
}

local icons = {
  Class = " ",
  Color = " ",
  Constant = "π ",
  Constructor = " ",
  Enum = "了",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "✂ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}
return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = { "rafamadriz/friendly-snippets" },

  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = "enter" },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      -- Disable auto brackets
      -- NOTE: some LSPs may add auto brackets themselves anyway
      accept = { auto_brackets = { enabled = false }, },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
        treesitter_highlighting = true,
        -- window = { border = "rounded" }
      },
      menu = {
        -- border = 'rounded',
        draw = {
          padding = { 0, 1 },
          columns = {
            { "label",     "label_description", gap = 1 },
            { "kind_icon", gap = 1,             "kind" }
          },
          components = {
            kind_icon = {
              text = function(ctx)
                if icons[ctx.kind] then
                  return icons[ctx.kind]
                end
              end,
            },
          }
        },
      }
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
-- return {
--   "hrsh7th/nvim-cmp",
--   dependencies = {
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-cmdline",
--     "saadparwaiz1/cmp_luasnip",
--     "onsails/lspkind.nvim",
--     "ray-x/cmp-treesitter",
--   },
--   config = function()
--     local cmp = require("cmp")
--     local lspkind = require("lspkind")
--
--     local source_mapping = {
--       nvim_lsp = "[LSP]",
--       nvim_lua = "[LUA]",
--       luasnip = "[SNIP]",
--       buffer = "[BUF]",
--       path = "[PATH]",
--       treesitter = "[TREE]",
--       cmp_ai = "[AI]",
--       ["vim-dadbod-completion"] = "[DB]",
--     }
--
--     local icons = {
--       Class = " ",
--       Color = " ",
--       Constant = "π ",
--       Constructor = " ",
--       Enum = "了",
--       EnumMember = " ",
--       Field = " ",
--       File = " ",
--       Folder = " ",
--       Function = " ",
--       Interface = "ﰮ ",
--       Keyword = " ",
--       Method = "ƒ ",
--       Module = " ",
--       Property = " ",
--       Snippet = "✂ ",
--       Struct = " ",
--       Text = " ",
--       Unit = " ",
--       Value = " ",
--       Variable = " ",
--     }
--
--     cmp.setup({
--       snippet = {
--         -- REQUIRED - you must specify a snippet engine
--         expand = function(args)
--           require("luasnip").lsp_expand(args.body)
--         end,
--       },
--       mapping = cmp.mapping.preset.insert({
--         ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
--         ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
--         ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),
--
--         ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--         ["<C-e>"] = cmp.mapping({
--           i = cmp.mapping.abort(),
--           c = cmp.mapping.close(),
--         }),
--         -- Accept currently selected item. If none selected, `select` first item.
--         -- Set `select` to `false` to only confirm explicitly selected items.
--         ["<CR>"] = cmp.mapping.confirm({ select = true }),
--       }),
--       sources = cmp.config.sources({
--         { name = "luasnip", group_index = 1 },
--         { name = "nvim_lsp", group_index = 2 },
--         { name = "path", group_index = 3 },
--         { name = "treesitter", keyword_length = 4, group_index = 4 },
--         { name = "buffer", keyword_length = 5, group_index = 4 },
--       }),
--
--       window = {
--         documentation = cmp.config.window.bordered(),
--         completion = cmp.config.window.bordered(),
--       },
--
--       performance = {
--         async_budget = 10,
--       },
--
--       formatting = {
--         format = function(_, vim_item)
--           if icons[vim_item.kind] then
--             vim_item.kind = icons[vim_item.kind] .. " " .. vim_item.kind
--           end
--           return vim_item
--         end,
--       },
--
--       experimental = {
--         native_menu = false,
--         ghost_text = false,
--       },
--     })
--
--     -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
--     cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })
--
--     -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--     cmp.setup.cmdline(":", {
--       sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
--       mapping = cmp.mapping.preset.cmdline({
--         -- Your configuration here.
--       }),
--     })
--   end,
-- }
