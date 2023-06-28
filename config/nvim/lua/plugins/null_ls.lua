return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local null_ls_custom = require("lib.null_ls_typos")
    local lspconfig = require("lspconfig")
    local eslint_root_pattern = {
      ".eslintrc.js",
      ".eslintrc.js",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".eslintrc.json",
    }

    null_ls.register(null_ls_custom.typos_code_actions)

    null_ls.setup({
      border = "rounded",
      sources = {
        null_ls.builtins.diagnostics.eslint_d.with({
          condition = function(utils)
            return utils.root_has_file(eslint_root_pattern)
          end,
        }),
        null_ls.builtins.diagnostics.write_good.with({
          filetypes = { "gitcommit", "markdown" },
        }),
        null_ls.builtins.formatting.prettierd.with({
          root_dir = lspconfig.util.root_pattern("package.json"),
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
            "json5",
            "yaml",
            "markdown",
            "graphql",
            "handlebars",
            "svelte",
            "astro",
          },

          -- condition = function(utils)
          --   return utils.root_has_file({ "deno.json", "deno.jsonc" }) == false
          -- end
        }),

        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.mix,

        null_ls.builtins.code_actions.eslint_d.with({
          root_dir = lspconfig.util.root_pattern(eslint_root_pattern),
          condition = function(utils)
            return utils.root_has_file(eslint_root_pattern)
          end,
        }),

        -- null_ls.builtins.formatting.eslint_d,

        null_ls.builtins.formatting.shfmt.with({
          extra_args = { "-i", "2" },
        }),

        null_ls.builtins.diagnostics.stylelint.with({
          prefer_local = "node_modules/.bin",
        }),

        -- null_ls.builtins.formatting.gofmt
      },

      on_attach = on_attach,
    })
  end,
}
