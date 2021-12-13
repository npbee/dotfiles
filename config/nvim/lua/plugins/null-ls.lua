local null_ls = require('null-ls')

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.misspell,
        null_ls.builtins.diagnostics.eslint_d
    }
})
