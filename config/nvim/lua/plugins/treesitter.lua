return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdateSync" },
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = { "javascript", "typescript", "tsx", "html", "css", "scss", "json", "graphql" },
    })
  end,
}
