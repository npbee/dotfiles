return {
  {
    "junegunn/fzf.vim",
    lazy = false,
    dependencies = {
      "junegunn/fzf",
      -- lazy = false,
      -- dir = " ~/.fzf",
      -- build = "./install --all",
      config = function()
        vim.g.fzf_layout = { window = { width = 0.95, height = 0.95 } }

        vim.g.fzf_preview_window = { "hidden,right,55%", "ctrl-p" }

        --   vim.cmd([[
        -- command! -bang -nargs=? -complete=dir Files
        --     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)
        -- ]])
        --
        --   vim.cmd([[
        -- command! -bang -nargs=* Rg
        --   \ call fzf#vim#grep(
        --   \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
        --   \   fzf#vim#with_preview('right:55%:hidden', 'ctrl-o'), <bang>0)
        --
        -- ]])
        --
        -- Like Rg, but no ignore
        vim.cmd([[
        command! -bang -nargs=* RGI
          \ call fzf#vim#grep(
          \   'rg --no-ignore --column --line-number --no-heading --color=always --smart-case '.<q-args>, 1,
          \   fzf#vim#with_preview('right:55%:hidden', 'ctrl-o'), <bang>0)
        ]])
      end,
    },

    keys = {
      { "<leader>p", ":Files<CR>", { noremap = true } },
      -- Search for word
      { "<leader>f", ":Rg ", { noremap = true } },
      -- Search for word under cursor
      -- { "<leader>rg", ":Rg <C-R><C-W><CR>", { noremap = true } },
      { "<leader>*", ":Rg <C-R><C-W><CR>", { noremap = true } },
      -- { "<leader>*", 'y:RG <C-R>"<CR>', { noremap = true } },
      -- " Fuzzy find buffers
      { "<leader>b", ":Buffers<CR>", { noremap = true } },
    },
  },

  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end,
    keys = {
      -- { "<leader>p", ":lua require('fzf-lua').files()<cr>",      { silent = true } },
      -- { "<leader>f", ":lua require('fzf-lua').grep()<cr>",       { silent = true, noremap = true } },
      -- { "<leader>*", ":lua require('fzf-lua').grep_cword()<cr>", { noremap = true } },
      -- { "<leader>b", ":lua require('fzf-lua').buffers()<CR>", { noremap = true } },
    },
  },
}
