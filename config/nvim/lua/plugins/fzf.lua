return {
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    config = function()
      require("fzf-lua").setup({
        winopts = {
          width = 0.95,
          height = 0.95,
          preview = {
            hidden = "hidden",
            layout = "horizontal",
            horizontal = "right:55%",
          },
        },
        keymap = {
          fzf = {
            ["ctrl-p"] = "toggle-preview",
          },
        },
      })

      -- Like Rg, but no ignore
      vim.api.nvim_create_user_command("RGI", function(opts)
        require("fzf-lua").grep({
          search = opts.args,
          rg_opts = "--no-ignore --column --line-number --no-heading --color=always --smart-case",
        })
      end, { nargs = "*", bang = true })
    end,
    keys = {
      { "<leader>p", function() require("fzf-lua").files() end,            desc = "Find files" },
      { "<leader>f", function() require("fzf-lua").grep() end,             desc = "Grep (prompt)" },
      { "<leader>F", function() require("fzf-lua").live_grep() end,        desc = "Live grep" },
      { "<leader>*", function() require("fzf-lua").grep_cword() end,       desc = "Search word under cursor" },
      { "<leader>b", function() require("fzf-lua").buffers() end,          desc = "Buffers" },
      { "grr",       function() require("fzf-lua").lsp_references() end,          desc = "Find references" },
      { "gO",        function() require("fzf-lua").lsp_document_symbols() end, desc = "Document symbols" },
      { "gra",       function() require("fzf-lua").lsp_code_actions() end,     desc = "Code actions" },
      { "gri",       function() require("fzf-lua").lsp_implementations() end,  desc = "Implementations" },
      { "<leader>d", function() require("fzf-lua").diagnostics_document() end, desc = "Diagnostics" },
    },
  },
}
