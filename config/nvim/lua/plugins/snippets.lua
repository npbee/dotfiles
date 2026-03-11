return {
  "L3MON4D3/LuaSnip",
  config = function()
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

    lua_loader.load({
      paths = "~/.config/nvim/lua/snippets",
    })

    -- Load from the repository root .vscode directory
    local root = vim.fs.root(0, '.git')
    if root then
      local snippets_path = root .. '/.vscode/snippets.code-snippets'
      if vim.uv.fs_stat(snippets_path) then
        vscode_loader.load_standalone({ path = snippets_path })
      end
    end

    vim.keymap.set({ "i", "s" }, "<c-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true, desc = "Snippet expand/jump" })

    vim.keymap.set({ "i", "s" }, "<c-j>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true, desc = "Snippet jump back" })

    vim.keymap.set("i", "<c-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { desc = "Snippet cycle choice" })

    -- reload all snippets
    -- vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

    -- Edit snippets
    vim.api.nvim_create_user_command("LuaSnipEdit", function()
      loaders.edit_snippet_files()
    end, {})
  end,
}
