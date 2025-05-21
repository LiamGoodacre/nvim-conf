return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", lazy = false, config = true },
    { "mason-org/mason-lspconfig.nvim", lazy = false },
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup(
      require("LiamGoodacre.language").mason_lspconfig()
    )
  end,
}
