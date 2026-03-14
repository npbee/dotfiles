-- Easier split navigation
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true, desc = "Move to right split" })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true, desc = "Move to left split" })

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
