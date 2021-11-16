# Dotfiles

- [Neovim](#neovim)

## Install

```bash
$ git clone git@github.com:npbee/dotfiles.git ~/.dotfiles
```

I've got an attempt at a one-script set up at

```bash
# From the cloned dotfiles directory
./init/mac
```

Other installs:

- [Kitty Terminal](https://github.com/kovidgoyal/kitty)

Fonts:

- From Dropbox, install term font and Pragmata Pro

## Neovim

To make a local configuration file, create a file here: `~/.config/nvim/init.local.vim`

It can look something like this:

```vim
let g:ale_linters['javascript'] = ['eslint', 'flow-language-server']
let g:ale_linters['javascriptreact'] = ['eslint', 'flow-language-server']
let g:ale_linters['typescript'] = ['eslint', 'tsserver']
let g:ale_linters['typescriptreact'] = ['eslint', 'tsserver']
let g:ale_linters['css'] = ['stylelint']

let g:ale_javascript_eslint_executable = 'eslint_d'

let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['javascriptreact'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['typescriptreact'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']
let g:ale_fixers['scss'] = ['prettier']
let g:ale_fixers['markdown'] = ['prettier']
let g:ale_fixers['markdown.mdx'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['yaml'] = ['prettier']
let g:ale_fixers['elixir'] = ['mix_format']


let g:test#javascript#jest#executable = 'yarn test --watch'

" Local LSP
" ----
lua require('lsp-local')
```

Create a local LSP config by creating a file here: `~/.config/nvim/lua/lsp-local.lua`

Can look like this:

```lua
require'lspconfig'.flow.setup{
  on_attach = on_attach,

  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
      }
    )
  }
}
```

## Required NPM packages

`@fsouza/prettierd`
