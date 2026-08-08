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

## Agent instructions

Shared, cross-tool agent preferences live in a single canonical file:
`config/agents/AGENTS.md`. Each tool's entry point is an in-repo symlink to it,
so `rcup` links them all on install:

- `claude/CLAUDE.md` -> `~/.claude/CLAUDE.md` (Claude Code global memory)
- `config/opencode/AGENTS.md` -> `~/.config/opencode/AGENTS.md` (opencode)

Edit `config/agents/AGENTS.md` only. Add a new tool by symlinking its file to
the canonical one and running `rcup`.

Claude Code's global settings live at `claude/settings.json` -> `~/.claude/settings.json`.
Claude Code writes to this file when settings change, and a rewrite can replace
the symlink with a regular file — check `ls -l ~/.claude/settings.json` and
re-run `rcup` if so. Machine-specific overrides belong in
`~/.claude/settings.local.json`, which is untracked and merges on top.

## Neovim

TODO

## Required NPM packages

`@fsouza/prettierd`

## LSP

- `npm install typescript-language-server vscode-langservers-extracted cssmodules-language-server`
- `brew install lua-language-server`
- https://github.com/crate-ci/typos
