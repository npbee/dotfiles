local null_ls = require("null-ls")
local null_ls_custom = require("plugins.null_ls")
local lspconfig = require("lspconfig")

-- Config ---------------------------------------------------------------------

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

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
  buf_set_keymap("n", "<leader>ca", ":lua require('telescope.builtin').lsp_code_actions()<CR>", opts)

  buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)

  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]] ,
      false
    )
  end
end

-- Typescript -----------------------------------------------------------------

-- Disabled until I'm actually using this somewhere
lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Use prettier for formatting
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    on_attach(client, bufnr)
  end,

  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
    }),
  },

  filetypes = {
    -- At work we use flow, so it's too slow to have both LSP servers running
    -- Disabling JS files for now
    -- 'javascript',
    -- 'javascriptreact',
    -- 'javascript.jsx',
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
})

-- Flow -----------------------------------------------------------------------

lspconfig.flow.setup({ capabilities = capabilities, on_attach = on_attach })

-- Null LS --------------------------------------------------------------------

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.write_good.with({
      filetypes = { "gitcommit", "markdown" },
    }),
    null_ls.builtins.formatting.prettierd.with({
      prefer_local = "node_modules/.bin",
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "jsonc",
        "yaml",
        "markdown",
        "graphql",
        "handlebars",
      },
    }),
    null_ls.builtins.formatting.prettier.with({
      prefer_local = "node_modules/.bin",
      filetypes = {
        "svelte",
      },
    }),
    -- null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.mix,

    null_ls.builtins.code_actions.eslint_d,
    -- null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.shfmt.with({
      extra_args = { "-i", "2" },
    }),

    null_ls.builtins.diagnostics.stylelint.with({
      prefer_local = "node_modules/.bin",
    }),
  },

  on_attach = on_attach,
})

-- null_ls.register(null_ls_custom.typos_diagnostics)
null_ls.register(null_ls_custom.typos_code_actions)

-- CSS ------------------------------------------------------------------------

lspconfig.cssls.setup({
  capabilities = capabilities,

  settings = {
    css = {
      validate = false,
    },
  },
})

lspconfig.cssmodules_ls.setup({})

-- Lua ------------------------------------------------------------------------

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },

      format = {
        defaultConfig = {
          indent_style = "space",
          indent_size = "2"
        }
      },
    },
  },
})

-- GraphQL --------------------------------------------------------------------
require("lspconfig").graphql.setup({})

-- Astro ----------------------------------------------------------------------
lspconfig.astro.setup({})

require("lsp_signature").setup({})
