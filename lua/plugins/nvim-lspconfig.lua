return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", lazy = false, config = true },
    { "williamboman/mason-lspconfig.nvim", lazy = false },
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup(
      require("LiamGoodacre.lsps").mason_lspconfig
    )
  end,
}
