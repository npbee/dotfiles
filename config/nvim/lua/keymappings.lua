local map = vim.api.nvim_set_keymap

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Easier split navigation
map("n", "<C-J>", "<C-W><C-J>", {noremap = true})
map("n", "<C-K>", "<C-W><C-K>", {noremap = true})
map("n", "<C-L>", "<C-W><C-L>", {noremap = true})
map("n", "<C-H>", "<C-W><C-H>", {noremap = true})

-- in visual mode, use tab for indenting
map("x", "<tab>", ">gv", {noremap = true})
map("x", "<s-tab>", "<gv", {noremap = true})

-- Cycle through buffers with tab
map("n", "<tab>", ":bnext<CR>", {noremap = true})
map("n", "<s-tab>", ":prev<CR>", {noremap = true})

-- Delete buffer
map("n", "<leader>q", ":bdelete<CR>", {noremap = true})

-- Double-tap leader to swap back to most recent file
map("n", "<leader><leader>", "<c-^>", {noremap = true})

-- Maps '%%' when in command mode to the active file directory
function _G.expand_path()
    return vim.fn.getcmdtype() == ":" and vim.fn.expand('%h') or '%%'
end

map("c", "%%", "v:lua.expand_path()", {noremap = true, expr = true})

-- Easy vertical split
map("n", "<leader>w", "<C-w>v<C-w>l", {noremap = true})

-- Easy horizontal split
-- map("n", "<leader>e", "<C-w>s<C-w>j", {noremap = true})

-- Turn off search highlighting
map("n", "<esc>", ":noh<CR>", {silent = true, noremap = true})

-- FZF: Open file
map("n", "<leader>p", ":FZF<CR>", {noremap = true})

-- FZF: Search for word
map("n", "<leader>f", ":Rg<Space>", {noremap = true})

-- FZF: Search for word (raw)
map("n", "<leader>F", ":RG<Space>", {noremap = true})

-- FZF: Search for word under cursor
map("n", "<leader>rg", ":Rg <C-R><C-W><CR>", {noremap = true})

-- FZF: Search for word under cursor (raw)
map("n", "<leader>*", ":RG <C-R><C-W><CR>", {noremap = true})
map("x", "<leader>*", 'y:RG <C-R>"<CR>', {noremap = true})

-- FZF: Buffers 
-- " Fuzzy find buffers
map("n", "<leader>b", ":Buffers<CR>", {noremap = true})

-- Ale: Toggle Fixing
map("n", "<F12>", ":call ToggleFixOnSave()<CR>", {noremap = true})

-- Ale: Go to definition
-- map("n", "gd", ":ALEGoToDefinition<CR>", {noremap = true, silent = true})

-- Ale: Find references
-- map("n", "gr", ":ALEFindReferences<CR>", {noremap = true, silent = true})

-- Ale: Show hover info
-- map("n", "K", ":ALEHover<CR>", {noremap = true, silent = true})

-- Ale: Show diagnostics
-- map("n", "<leader>e", ":ALEDetail<CR>", {noremap = true, silent = true})

-- Ale: Cycle through issues
map("n", "<leader>aj", ":ALENextWrap<CR>", {noremap = true})
map("n", "<leader>ak", ":ALEPreviousWrap<CR>", {noremap = true})

-- Ale: Kill LSPs
map("n", "<leader>ax", ":ALEStopAllLSPs<CR>", {noremap = true})

-- Vim test
map("n", "t<C-n>", ":TestNearest<CR>", {silent = true})
map("n", "t<C-f>", ":TestFile<CR>", {silent = true})
map("n", "t<C-s>", ":TestSuite<CR>", {silent = true})
map("n", "t<C-l>", ":TestLast<CR>", {silent = true})
map("n", "t<C-g>", ":TestVisit<CR>", {silent = true})

-- Neoterm: Toggle terminal window
map("n", "<leader>tt", ":Ttoggle<CR>", {silent = true})

-- Neoterm: Close terminal window and kill the process
map("n", "<leader>tx", ":Tclose!<CR>", {silent = true})

-- Vsnip: expand snippet
map("i", "<C-k>", "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-k>'",
    {expr = true})
map("s", "<C-k>", "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-k>'",
    {expr = true})

-- Vsnip: expand or jump 
map("i", "<C-l>",
    "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'",
    {expr = true})
map("s", "<C-l>",
    "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'",
    {expr = true})

-- Vsnip: jump 
map("i", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
    {expr = true})
map("s", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
    {expr = true})
map("i", "<S-Tab>",
    "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", {expr = true})
map("s", "<S-Tab>",
    "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", {expr = true})
