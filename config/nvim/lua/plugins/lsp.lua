vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = false,
      float = {
        border = "rounded",
        -- header = "Noise",
        format = function(diagnostic)
          local format = "[%s] %s"
          if diagnostic.code then
            format = format .. " (%s)"
          end
          return string.format(format, diagnostic.source, diagnostic.message, diagnostic.code)
        end,
      },
    })


    -- Mappings.
    local opts = { noremap = true, silent = true, buffer = ev.buf }
    -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set("n", "<space>wl", function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "grr", function()
      require("telescope.builtin").lsp_references()
    end, opts)
    -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    -- vim.keymap.set('n', '<space>f', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
  end,
})

return {
  "neovim/nvim-lspconfig",
  config = function()
    local util = require('lspconfig.util')

    vim.lsp.enable({ "marksman",
      "ts_ls",
      "bashls",
      "cssls",
      "lua_ls",
      "astro",
      "tailwindcss",
      "elixirls",
      "svelte",
      "eslint"
    })

    -- Lua ------------------------------------------------------------------------

    vim.lsp.config('lua_ls', {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
              path ~= vim.fn.stdpath('config')
              and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Tell the language server how to find Lua modules same way as Neovim
            -- (see `:h lua-module-load`)
            path = {
              'lua/?.lua',
              'lua/?/init.lua',
            },
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths
              -- here.
              -- '${3rd}/luv/library'
              -- '${3rd}/busted/library'
            }
            -- Or pull in all of 'runtimepath'.
            -- NOTE: this is a lot slower and will cause issues when working on
            -- your own configuration.
            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
            -- library = {
            --   vim.api.nvim_get_runtime_file('', true),
            -- }
          }
        })
      end,
      settings = {
        Lua = {}
      }
    })

    vim.lsp.config("tailwindcss", {
      settings = {
        tailwindCSS = {
          classFunctions = { "cva" },
        },
      },
      -- root_dir = function(fname)
      --   local root_file = {
      --     'tailwind.config.js',
      --     'tailwind.config.cjs',
      --     'tailwind.config.mjs',
      --     'tailwind.config.ts',
      --   }
      --   root_file = util.insert_package_json(root_file, 'tailwindcss', fname)
      --   return util.root_pattern(unpack(root_file))(fname)
      -- end,
    })

    vim.lsp.config('elixirls', {
      cmd = { vim.fn.expand("$HOME/.bin/elixir-ls/language_server.sh") },
    })

    vim.lsp.config("eslint", {
      settings = {
        -- eslint_d provides lint errors
        quiet = true,
      },
    })
  end,
}
