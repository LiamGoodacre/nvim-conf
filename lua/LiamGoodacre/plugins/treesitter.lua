return {
  "neovim-treesitter/nvim-treesitter",
  name = "nvim-treesitter",
  dependencies = { "neovim-treesitter/treesitter-parser-registry" },
  lazy = false,
  build = ":TSUpdate",
}
