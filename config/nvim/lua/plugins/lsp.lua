local util = require('util')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Mappings.
    local opts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gr", function()
      require('telescope.builtin').lsp_references()
    end, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    -- vim.keymap.set('n', '<space>f', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
  end
})


return {
  { "folke/lsp-colors.nvim" },
  { "ray-x/lsp_signature.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Config ---------------------------------------------------------------------
      require("lspconfig.ui.windows").default_options.border = "rounded"

      --Enable (broadcasting) snippet capability for completion
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      capabilities.textDocument.completion.completionItem.snippetSupport = true

      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
        float = {
          border = "rounded",
          header = { "", "Noise" },
          format = function(diagnostic)
            local format = "[%s] %s"
            if diagnostic.code then
              format = format .. " (%s)"
            end
            return string.format(format, diagnostic.source, diagnostic.message, diagnostic.code)
          end,
        },
      })

      lspconfig.marksman.setup({})

      lspconfig.tsserver.setup({
        root_dir = util.root_pattern_exclude({
          root = { "package.json" },
          exclude = { "deno.json", "deno.jsonc" }
        }),
        single_file_support = false
      })


      lspconfig.eslint.setup({
        root_dir = util.root_pattern_exclude({
          root = { "package.json" },
          exclude = { "deno.json", "deno.jsonc" }
        })
      })

      -- CSS ------------------------------------------------------------------------

      lspconfig.cssls.setup({
        capabilities = capabilities,
      })

      -- Lua ------------------------------------------------------------------------

      local runtime_path = vim.split(package.path, ";")
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      lspconfig.lua_ls.setup({
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using
                  -- (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT'
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                  }
                  -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                  -- library = vim.api.nvim_get_runtime_file("", true)
                }
              }
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end
          return true
        end
      })

      -- Astro ----------------------------------------------------------------------
      lspconfig.astro.setup({
        root_dir = lspconfig.util.root_pattern({ "astro.config.mjs", "astro.config.js" }),
      })

      require("lsp_signature").setup({})

      require("lspconfig").tailwindcss.setup({
        root_dir = lspconfig.util.root_pattern({ "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts" }),
      })

      lspconfig.denols.setup({
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc", "deno.lock"),
        init_options = {
          lint = true,
          suggest = {
            imports = {
              hosts = {
                ["https://deno.land"] = true,
              },
            },
          },
        },
      })
      require("lspconfig").gopls.setup({})

      lspconfig.elixirls.setup({
        cmd = { vim.fn.expand("$HOME/.bin/elixir-ls/language_server.sh") }
      })

      lspconfig.svelte.setup({})
    end,
  },
}
