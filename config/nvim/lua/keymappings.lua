-- Split navigation is handled by vim-tmux-navigator (<C-h/j/k/l>), which
-- moves seamlessly between Neovim splits and tmux panes. See config/tmux.conf.

vim.keymap.set("n", "<C-s>", ":w<cr>", { noremap = true, desc = "Save file" })

vim.keymap.set("v", "<C-f>", vim.lsp.buf.format, { desc = "Format selection" })

-- in visual mode, use tab for indenting
vim.keymap.set("x", "<tab>", ">gv", { noremap = true, desc = "Indent selection" })
vim.keymap.set("x", "<s-tab>", "<gv", { noremap = true, desc = "Dedent selection" })

-- Cycle through buffers with tab
vim.keymap.set("n", "<tab>", ":bnext<CR>", { noremap = true, desc = "Next buffer" })
vim.keymap.set("n", "<s-tab>", ":bprev<CR>", { noremap = true, desc = "Previous buffer" })

-- Double-tap leader to swap back to most recent file
vim.keymap.set("n", "<leader><leader>", "<c-^>", { noremap = true, desc = "Alternate file" })

-- Maps '%%' when in command mode to the active file directory
function _G.expand_path()
  return vim.fn.getcmdtype() == ":" and vim.fn.expand("%:h") or "%%"
end

vim.keymap.set("c", "%%", "v:lua.expand_path()", { noremap = true, expr = true, desc = "Expand to file directory" })

-- Easy vertical split
vim.keymap.set("n", "<leader>w", "<C-w>v<C-w>l", { noremap = true, desc = "Vertical split" })

-- Turn off search highlighting
vim.keymap.set("n", "<esc>", ":noh<CR>", { silent = true, noremap = true, desc = "Clear search highlight" })

-- System clipboard yank/paste
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { noremap = true, desc = "Yank to system clipboard" })
-- vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { noremap = true, desc = "Paste from system clipboard" })

-- Substitute word under cursor across the whole file
vim.keymap.set("n", "gsw", [[:%s/\<<c-r><c-w>\>//g<left><left>]],
  { noremap = true, desc = "Substitute word under cursor" })
vim.keymap.set("n", "gsW", [[:*s/\<<c-r><c-w>\>//g<left><left>]],
  { noremap = true, desc = "Substitute word under cursor in last selection" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, desc = "Exit terminal mode" })

-- Toggle formatting
vim.keymap.set("n", "<F12>", ":FormatToggle<cr>", { noremap = true, desc = "Toggle autoformat" })

-- Toggle spell
vim.keymap.set("n", "<F10>", "<cmd>: set spell!<CR>", { noremap = true, desc = "Toggle spellcheck" })

-- QF Helpers
vim.keymap.set("n", "<C-N>", "<CMD>QNext<CR>", { noremap = true, desc = "Next quickfix item" })
vim.keymap.set("n", "<C-P>", "<CMD>QPrev<CR>", { noremap = true, desc = "Previous quickfix item" })
vim.keymap.set("n", "<leader>q", "<CMD>QFToggle!<CR>", { noremap = true, desc = "Toggle quickfix" })
vim.keymap.set("n", "<leader>l", "<CMD>LLToggle!<CR>", { noremap = true, desc = "Toggle loclist" })
