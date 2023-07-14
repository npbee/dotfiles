return {
  "L3MON4D3/LuaSnip",
  config = function()
    local ls = require("luasnip")
    local loaders = require("luasnip.loaders")
    local lua_loader = require("luasnip.loaders.from_lua")

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

    -- Expand or jump snippets with control+k
    vim.keymap.set({ "i", "s" }, "<c-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    -- Go back to previous item
    vim.keymap.set({ "i", "s" }, "<c-j>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    -- Cycle through choice nodes
    vim.keymap.set("i", "<c-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    -- reload all snippets
    vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

    -- Edit snippets
    vim.api.nvim_create_user_command("LuaSnipEdit", function()
      loaders.edit_snippet_files()
    end, {})
  end,
}
