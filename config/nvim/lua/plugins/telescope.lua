return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  config = function()
    local telescope = require("telescope")
    local builtins = require("telescope.builtin")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        dynamic_preview_title = true,
        -- layout_strategy = "vertical",
        layout_config = {
          horizontal = {
            height = 0.95,
            width_padding = 0.04,
            height_padding = 0.1,
            preview_width = 0.6,
          },
          vertical = {
            height = 0.95,
            width_padding = 0.05,
            height_padding = 1,
            preview_height = 0.5,
          },
        },
        mappings = {
          i = {
            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            ["<esc>"] = actions.close,
          },
        },
        preview = {
          hide_on_startup = true,
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            -- even more opts
          }),
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,
  keys = {
    -- Search for word (raw)
    { "<leader>F", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { noremap = true } },
    { "gp", ":lua require('plugins.telescope').react_prop_usage()<CR>", { noremap = true } },
    { "<leader>tp", "<cmd>:lua require('telescope.builtin').builtin()<cr>", { noremap = true } },
  },
}
