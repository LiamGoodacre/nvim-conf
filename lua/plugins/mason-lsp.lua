return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", lazy = false, config = true },
    { "williamboman/mason-lspconfig.nvim", lazy = false },
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup(
      require("LiamGoodacre.language").mason_lspconfig()
    )
  end,
}
