-- PackChanged hooks (must be created BEFORE vim.pack.add)
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    if name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    elseif name == 'tree-sitter-ghostty' then
      if not ev.data.active then vim.cmd.packadd('tree-sitter-ghostty') end
      vim.fn.system('make nvim_install')
    end
  end,
})

vim.pack.add({
  -- Formatting
  'https://github.com/stevearc/conform.nvim',

  -- Linting
  'https://github.com/mfussenegger/nvim-lint',

  -- Git links
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/ruifm/gitlinker.nvim',

  -- File browser
  'https://github.com/justinmk/vim-dirvish',
  'https://github.com/roginfarrer/vim-dirvish-dovish',

  -- Comments
  'https://github.com/numToStr/Comment.nvim',

  -- Terminal / testing
  'https://github.com/kassio/neoterm',
  'https://github.com/vim-test/vim-test',

  -- Fuzzy finder
  'https://github.com/ibhagwan/fzf-lua',

  -- Completion
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.x') },

  -- LSP
  'https://github.com/neovim/nvim-lspconfig',

  -- Snippets
  'https://github.com/L3MON4D3/LuaSnip',

  -- Treesitter
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/bezhermoso/tree-sitter-ghostty',

  -- Mini
  'https://github.com/echasnovski/mini.colors',
  'https://github.com/echasnovski/mini.clue',
  'https://github.com/echasnovski/mini.surround',
  'https://github.com/echasnovski/mini.ai',

  -- Copilot
  'https://github.com/github/copilot.vim',
  'https://github.com/fang2hou/blink-copilot',
})

--------------------------------------------------------------------------------
-- Plugin configuration
--------------------------------------------------------------------------------

-- conform.nvim ----------------------------------------------------------------

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

vim.api.nvim_create_user_command("FormatDisable", function()
  vim.g.disable_autoformat = true
end, { desc = "Disable autoformat-on-save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.g.disable_autoformat = false
end, { desc = "Re-enable autoformat-on-save" })

vim.api.nvim_create_user_command("FormatToggle", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
end, { desc = "Toggle autoformat-on-save" })

vim.api.nvim_create_user_command("Formatters", function()
  print(vim.inspect(require("conform").list_formatters()))
end, { desc = "Show available formatters" })

require("conform").formatters.shfmt = {
  prepend_args = { "-i", "2" },
}

require("conform").setup({
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat then
      return
    end
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("/node_modules/") then
      return
    end
    return { timeout_ms = 1000, lsp_fallback = true }
  end,
  formatters_by_ft = {
    css = { "oxfmt", "prettierd", stop_after_first = true },
    html = { "prettierd" },
    javascript = { "oxfmt", "prettierd", stop_after_first = true },
    javascriptreact = { "oxfmt", "prettierd", stop_after_first = true },
    json = { "oxfmt", "prettierd", stop_after_first = true },
    markdown = { "prettierd" },
    scss = { "prettierd" },
    yaml = { "prettierd" },
    prisma = { "prettierd" },
    sh = { "shfmt" },
    elixir = { "mix" },
    python = { "lsp" },
    typescript = { "oxfmt", "prettierd", stop_after_first = true },
    typescriptreact = { "oxfmt", "prettierd", stop_after_first = true },
  },
})

-- nvim-lint ------------------------------------------------------------------

vim.env.ESLINT_D_PPID = vim.fn.getpid()
require("lint").linters_by_ft = {
  typescript = { "oxlint", "eslint_d" },
  typescriptreact = { "oxlint", "eslint_d" },
  javascript = { "oxlint", "eslint_d" },
  javascriptreact = { "oxlint", "eslint_d" },
  svelte = { "oxlint", "eslint_d" },
}

-- gitlinker -------------------------------------------------------------------

require("gitlinker").setup({
  callbacks = {
    ["github-emu"] = function(url_data)
      local url = require("gitlinker.hosts").get_github_type_url(url_data)
      return url:gsub("(github%-emu)", "github.com")
    end,
  },
})

-- vim-dirvish -----------------------------------------------------------------

vim.g.dirvish_mode = ":sort ,^.*[\\/],"

-- Comment.nvim ----------------------------------------------------------------

require("Comment").setup()

-- neoterm / vim-test ----------------------------------------------------------

vim.g.neoterm_default_mod = "vertical"
vim.g.neoterm_autoinsert = 0

vim.g["test#strategy"] = "neoterm"
vim.g["test#javascript#jest#options"] = "--watch"
vim.g["test#javascript#vitest#options"] = "--watch"

vim.keymap.set("n", "t<C-n>", ":TestNearest<CR>", { desc = "Test nearest" })
vim.keymap.set("n", "t<C-f>", ":TestFile<CR>", { desc = "Test file" })
vim.keymap.set("n", "t<C-s>", ":TestSuite<CR>", { desc = "Test suite" })
vim.keymap.set("n", "t<C-l>", ":TestLast<CR>", { desc = "Test last" })
vim.keymap.set("n", "t<C-g>", ":TestVisit<CR>", { desc = "Test visit" })
vim.keymap.set("n", "t<C-x>", ":Tkill<CR>:Tclose!<CR>", { desc = "Kill and close terminal" })
vim.keymap.set("n", "t<C-o>", ":Ttoggle<CR>", { desc = "Toggle terminal" })

-- fzf-lua ---------------------------------------------------------------------

require("fzf-lua").setup({
  winopts = {
    width = 0.95,
    height = 0.95,
    preview = {
      hidden = "hidden",
      layout = "horizontal",
      horizontal = "right:55%",
    },
  },
  keymap = {
    builtin = {
      ["<C-p>"] = "toggle-preview",
    },
  },
})

vim.api.nvim_create_user_command("RGI", function(opts)
  require("fzf-lua").grep({
    search = opts.args,
    rg_opts = "--no-ignore --column --line-number --no-heading --color=always --smart-case",
  })
end, { nargs = "*", bang = true })

vim.keymap.set("n", "<leader>p", function() require("fzf-lua").files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>f", function() require("fzf-lua").grep() end, { desc = "Grep (prompt)" })
vim.keymap.set("n", "<leader>F", function() require("fzf-lua").live_grep() end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>*", function() require("fzf-lua").grep_cword() end, { desc = "Search word under cursor" })
vim.keymap.set("n", "<leader>b", function() require("fzf-lua").buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "grr", function() require("fzf-lua").lsp_references() end, { desc = "Find references" })
vim.keymap.set("n", "gO", function() require("fzf-lua").lsp_document_symbols() end, { desc = "Document symbols" })
vim.keymap.set("n", "gra", function() require("fzf-lua").lsp_code_actions() end, { desc = "Code actions" })
vim.keymap.set("n", "gri", function() require("fzf-lua").lsp_implementations() end, { desc = "Implementations" })
vim.keymap.set("n", "<leader>d", function() require("fzf-lua").diagnostics_document() end, { desc = "Diagnostics" })

-- blink.cmp -------------------------------------------------------------------

local cmp_icons = {
  Class = " ",
  Color = " ",
  Constant = "π ",
  Constructor = " ",
  Enum = "了",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "✂ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<C-y>'] = { 'select_and_accept', 'fallback' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    accept = { auto_brackets = { enabled = false } },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
      treesitter_highlighting = true,
    },
    menu = {
      draw = {
        padding = { 0, 1 },
        columns = {
          { "label",     "label_description", gap = 1 },
          { "kind_icon", gap = 1,             "kind" },
        },
        components = {
          kind_icon = {
            text = function(ctx)
              if cmp_icons[ctx.kind] then
                return cmp_icons[ctx.kind]
              end
            end,
          },
        },
      },
    },
  },
  snippets = { preset = 'luasnip' },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
    prebuilt_binaries = { force_version = 'v1.10.1' },
  },
})

-- nvim-lspconfig --------------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    vim.diagnostic.config({
      severity_sort = true,
      update_in_insert = false,
      float = {
        border = "rounded",
        source = "if_many",
      },
      virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = 'E',
          [vim.diagnostic.severity.WARN] = 'W',
          [vim.diagnostic.severity.INFO] = 'I',
          [vim.diagnostic.severity.HINT] = 'H',
        },
      },
      underline = true,
    })

    local opts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float,
      vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
  end,
})

vim.lsp.enable({
  "marksman", "vtsls", "bashls", "cssls", "lua_ls", "astro",
  "tailwindcss", "elixirls", "svelte", "eslint", "ruff",
  "jedi_language_server", "copilot", "oxlint",
})

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
        version = 'LuaJIT',
        path = { 'lua/?.lua', 'lua/?/init.lua' },
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    })
  end,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = { 'lua/?.lua', 'lua/?/init.lua' },
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
})

vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      classFunctions = { "cva" },
    },
  },
})

vim.lsp.config('elixirls', {
  cmd = { vim.fn.expand("$HOME/.bin/elixir-ls/language_server.sh") },
})

vim.lsp.config("eslint", {
  settings = { quiet = true },
})

vim.lsp.config('ruff', {
  settings = {},
})

vim.lsp.config('oxlint', {
  cmd = { 'oxlint', '--lsp' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(vim.fs.dirname(vim.fs.find({ '.oxlintrc.json', 'package.json', '.git' }, { path = fname, upward = true })[1]))
  end,
  settings = {},
})

-- LuaSnip ---------------------------------------------------------------------

local ls = require("luasnip")
local loaders = require("luasnip.loaders")
local lua_loader = require("luasnip.loaders.from_lua")
local vscode_loader = require("luasnip.loaders.from_vscode")

ls.log.set_loglevel("info")

ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
})

ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascript", "javascriptreact", "typescript" })
ls.filetype_extend("javascriptreact", { "javascript" })

lua_loader.load({ paths = "~/.config/nvim/lua/snippets" })

local root = vim.fs.root(0, '.git')
if root then
  local snippets_path = root .. '/.vscode/snippets.code-snippets'
  if vim.uv.fs_stat(snippets_path) then
    vscode_loader.load_standalone({ path = snippets_path })
  end
end

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then ls.expand_or_jump() end
end, { silent = true, desc = "Snippet expand/jump" })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then ls.jump(-1) end
end, { silent = true, desc = "Snippet jump back" })

vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then ls.change_choice(1) end
end, { desc = "Snippet cycle choice" })

vim.api.nvim_create_user_command("LuaSnipEdit", function()
  loaders.edit_snippet_files()
end, {})

-- nvim-treesitter -------------------------------------------------------------

require("nvim-treesitter").setup({
  ensure_installed = { "javascript", "typescript", "tsx", "html", "css", "scss", "json", "graphql" },
})

-- mini ------------------------------------------------------------------------

local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = 'i', keys = '<C-x>' },
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = "'" },
    { mode = 'x', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = '`' },
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
    { mode = 'n', keys = '<C-w>' },
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
    { mode = 'n', keys = 's' },
    { mode = 'x', keys = 's' },
  },
  clues = {
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
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
    config = { width = 50 },
    delay = 500,
  },
})

require("mini.surround").setup()
require("mini.ai").setup()
