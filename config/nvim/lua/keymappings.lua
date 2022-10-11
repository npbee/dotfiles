local map = vim.api.nvim_set_keymap

-- Easier split navigation
map("n", "<C-J>", "<C-W><C-J>", { noremap = true })
map("n", "<C-K>", "<C-W><C-K>", { noremap = true })
map("n", "<C-L>", "<C-W><C-L>", { noremap = true })
map("n", "<C-H>", "<C-W><C-H>", { noremap = true })

map("n", "<C-s>", ":w<cr>", { noremap = true })

-- in visual mode, use tab for indenting
map("x", "<tab>", ">gv", { noremap = true })
map("x", "<s-tab>", "<gv", { noremap = true })

-- Cycle through buffers with tab
map("n", "<tab>", ":bnext<CR>", { noremap = true })
map("n", "<s-tab>", ":prev<CR>", { noremap = true })

-- Delete buffer
map("n", "<leader>q", ":bdelete<CR>", { noremap = true })

-- Double-tap leader to swap back to most recent file
map("n", "<leader><leader>", "<c-^>", { noremap = true })

-- Maps '%%' when in command mode to the active file directory
function _G.expand_path()
  return vim.fn.getcmdtype() == ":" and vim.fn.expand("%h") or "%%"
end

map("c", "%%", "v:lua.expand_path()", { noremap = true, expr = true })

-- Easy vertical split
map("n", "<leader>w", "<C-w>v<C-w>l", { noremap = true })

-- Turn off search highlighting
map("n", "<esc>", ":noh<CR>", { silent = true, noremap = true })

map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- Finders --------------------------------------------------------------------

-- FZF: Open file
map("n", "<leader>p", ":Files<CR>", { noremap = true })
-- map("n", "<leader>p", "<cmd>Telescope find_files<CR>", { noremap = true })

-- FZF: Search for word
map("n", "<leader>f", ":Rg ", { noremap = true })
-- map("n", "<leader>f", "<cmd>Telescope live_grep<CR>", { noremap = true })

-- FZF: Search for word (raw)
map("n", "<leader>F", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { noremap = true })

-- FZF: Search for word under cursor
map("n", "<leader>rg", ":Rg <C-R><C-W><CR>", { noremap = true })
-- map("n", "<leader>*", ":lua require('telescope.builtin').grep_string()<cr>", {noremap = true})

-- FZF: Search for word under cursor (raw)
map("n", "<leader>*", ":RG <C-R><C-W><CR>", { noremap = true })
-- map("n", "<leader>*", ":lua require('telescope.builtin').grep_string()<cr>", { noremap = true })
map("x", "<leader>*", 'y:RG <C-R>"<CR>', { noremap = true })

map("n", "gp", ":lua require('plugins.telescope').react_prop_usage()<CR>", { noremap = true })
map("n", "<leader>ge", ":silent !eslint_d % --fix<CR>", { noremap = true })

-- FZF: Buffers
-- " Fuzzy find buffers
map("n", "<leader>b", ":Buffers<CR>", { noremap = true })

-- Telescope: Run a builtin picker
-- TODO: Fix this!
map("n", "<leader>tp", "<cmd>:lua require('telescope.builtin').builtin()<cr>", { noremap = true })

-- Toggle formatting
map("n", "<F12>", "<cmd>: lua require('util').toggle_formatting()<CR>", { noremap = true })

-- Toggle spell
map("n", "<F10>", "<cmd>: set spell!<CR>", { noremap = true })

-- Vim test
map("n", "t<C-n>", ":TestNearest<CR>", { silent = true })
map("n", "t<C-f>", ":TestFile<CR>", { silent = true })
map("n", "t<C-s>", ":TestSuite<CR>", { silent = true })
map("n", "t<C-l>", ":TestLast<CR>", { silent = true })
map("n", "t<C-g>", ":TestVisit<CR>", { silent = true })

-- Neoterm: Toggle terminal window
map("n", "<leader>tt", ":Ttoggle<CR>", { silent = true })

-- Neoterm: Close terminal window and kill the process
map("n", "<leader>tx", ":Tclose!<CR>", { silent = true })

-- Vsnip: expand snippet
map("i", "<C-k>", "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-k>'", { expr = true })
map("s", "<C-k>", "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-k>'", { expr = true })

-- Vsnip: expand or jump
map("i", "<C-l>", "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'", { expr = true })
map("s", "<C-l>", "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'", { expr = true })

-- Vsnip: jump
map("i", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'", { expr = true })
map("s", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'", { expr = true })
map("i", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", { expr = true })
map("s", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", { expr = true })

-- Trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
