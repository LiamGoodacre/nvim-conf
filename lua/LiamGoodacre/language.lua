return {
  -- see ../plugins/mason-lsp.lua
  mason_lspconfig = function()
    local ensure_installed = {}

    require("LiamGoodacre.util").lsmod(
      "LiamGoodacre.languages",
      function(language_module)
        for _, lsp in ipairs(require(language_module).lsps) do
          table.insert(ensure_installed, lsp)
        end
      end
    )

    return {
      ensure_installed = ensure_installed,
    }
  end,

  setup = function()
    require("LiamGoodacre.util").lsmod(
      "LiamGoodacre.languages",
      function(language_module) require(language_module).setup() end
    )
  end,
}
