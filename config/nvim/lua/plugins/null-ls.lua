local null_ls = require('null-ls')

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.misspell,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.prettierd
    },

    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()")
        end
    end
})
