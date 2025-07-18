return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", lazy = false, config = true },
    { "mason-org/mason-lspconfig.nvim", lazy = false },
    { "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = false },
  },
  config = function()

    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed =
        require("LiamGoodacre.util").fold_modules(
          "LiamGoodacre.languages",
          function(language_module)
            return require(language_module).lsps
          end,
          {}
        ),
    })

    require("mason-tool-installer").setup({
      ensure_installed =
        require("LiamGoodacre.util").fold_modules(
          "LiamGoodacre.languages",
          function(language_module)
            return require(language_module).tools
          end,
          { "tree-sitter-cli" }
        ),
    })

  end,
}
