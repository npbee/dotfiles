return {
  { "folke/lsp-colors.nvim" },
  { "ray-x/lsp_signature.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")
      local typescript = require("typescript")
      local utils = require("util")

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

      -- Shared attach handler ------------------------------------------------------
      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
          filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls" or client.name == "denols" or client.name == "svelte"
          end,
          bufnr = bufnr,
        })
      end

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        local opts = { noremap = true, silent = true }
        buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
        buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

        -- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)

        -- buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        -- buf_set_keymap("n", "<leader>ca", ":lua require('telescope.builtin').lsp_code_actions()<CR>", opts)
        buf_set_keymap("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)

        buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
        -- buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)

        -- if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            if utils.is_formatting() == true then
              lsp_formatting(bufnr)
            end
          end,
        })
        -- end

        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_exec(
            [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
          )
        end
      end

      -- Typescript -----------------------------------------------------------------

      typescript.setup({
        server = {
          single_file_support = false,
          root_dir = lspconfig.util.root_pattern("tsconfig.json"),
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- Use prettier for formatting
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattignProvider = false

            on_attach(client, bufnr)
          end,

          handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
              virtual_text = false,
            }),
          },

          filetypes = {
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
        },
        --
      })
      -- Disabled until I'm actually using this somewhere

      -- Flow -----------------------------------------------------------------------

      lspconfig.flow.setup({ capabilities = capabilities, on_attach = on_attach })

      -- CSS ------------------------------------------------------------------------

      lspconfig.cssls.setup({
        capabilities = capabilities,

        settings = {
          css = {
            validate = false,
          },
        },
      })

      -- lspconfig.cssmodules_ls.setup({})

      -- Lua ------------------------------------------------------------------------

      local runtime_path = vim.split(package.path, ";")
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          -- Lua = {
          --   runtime = {
          --     -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          --     version = "LuaJIT",
          --     -- Setup your lua path
          --     path = runtime_path,
          --   },
          --   diagnostics = {
          --     -- Get the language server to recognize the `vim` global
          --     globals = { "vim" },
          --   },
          --   workspace = {
          --     -- Make the server aware of Neovim runtime files
          --     library = vim.api.nvim_get_runtime_file("", true),
          --   },
          --   -- Do not send telemetry data containing a randomized but unique identifier
          --   telemetry = {
          --     enable = false,
          --   },
          --
          format = {
            enable = false,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
            },
          },
          -- },
        },
      })

      -- GraphQL --------------------------------------------------------------------
      -- require("lspconfig").graphql.setup({})

      -- Astro ----------------------------------------------------------------------
      lspconfig.astro.setup({
        root_dir = lspconfig.util.root_pattern("astro.config.mjs"),
      })

      require("lsp_signature").setup({})

      require("lspconfig").tailwindcss.setup({
        root_dir = lspconfig.util.root_pattern({ "tailwind.config.js", "tailwind.config.cjs" }),
      })

      lspconfig.denols.setup({
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
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

      if not configs.ls_emmet then
        configs.ls_emmet = {
          default_config = {
            cmd = { "ls_emmet", "--stdio" },
            filetypes = {
              "html",
              "css",
              "scss",
              "javascriptreact",
              "typescriptreact",
              "haml",
              "xml",
              "xsl",
              "pug",
              "slim",
              "sass",
              "stylus",
              "less",
              "sss",
              "hbs",
              "handlebars",
            },
            root_dir = function()
              return vim.loop.cwd()
            end,
            settings = {},
          },
        }
      end

      lspconfig.ls_emmet.setup({ capabilities = capabilities })

      lspconfig.svelte.setup({ on_attach = on_attach })
    end,
  },
}