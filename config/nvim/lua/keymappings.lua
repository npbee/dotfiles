-- Easier split navigation
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true })

vim.keymap.set("n", "<C-s>", ":w<cr>", { noremap = true })

vim.keymap.set("v", "<C-f>", vim.lsp.buf.format)

-- in visual mode, use tab for indenting
vim.keymap.set("x", "<tab>", ">gv", { noremap = true })
vim.keymap.set("x", "<s-tab>", "<gv", { noremap = true })

-- Cycle through buffers with tab
vim.keymap.set("n", "<tab>", ":bnext<CR>", { noremap = true })
vim.keymap.set("n", "<s-tab>", ":prev<CR>", { noremap = true })

-- Double-tap leader to swap back to most recent file
vim.keymap.set("n", "<leader><leader>", "<c-^>", { noremap = true })

-- Maps '%%' when in command mode to the active file directory
function _G.expand_path()
  return vim.fn.getcmdtype() == ":" and vim.fn.expand("%h") or "%%"
end

vim.keymap.set("c", "%%", "v:lua.expand_path()", { noremap = true, expr = true })

-- Easy vertical split
vim.keymap.set("n", "<leader>w", "<C-w>v<C-w>l", { noremap = true })

-- Turn off search highlighting
vim.keymap.set("n", "<esc>", ":noh<CR>", { silent = true, noremap = true })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

vim.keymap.set("v", "<leader>f", ":lua vim.lsp.buf.format<CR>", { noremap = false })

-- Finders --------------------------------------------------------------------

vim.keymap.set("n", "<leader>ge", ":silent !eslint_d % --fix<CR>", { noremap = true })

-- Toggle formatting
vim.keymap.set("n", "<F12>", ":FormatToggle<cr>", { noremap = true })

-- Toggle spell
vim.keymap.set("n", "<F10>", "<cmd>: set spell!<CR>", { noremap = true })

-- QF Helpers

-- use <C-N> and <C-P> for next/prev.
vim.keymap.set("n", "<C-N>", "<CMD>QNext<CR>", { noremap = true })
vim.keymap.set("n", "<C-P>", "<CMD>QPrev<CR>", { noremap = true })
-- toggle the quickfix open/closed without jumping to it
vim.keymap.set("n", "<leader>q", "<CMD>QFToggle!<CR>", { noremap = true })
vim.keymap.set("n", "<leader>l", "<CMD>LLToggle!<CR>", { noremap = true })
