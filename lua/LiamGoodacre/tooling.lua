local M = {}

M.setup = function()

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

end

return M
