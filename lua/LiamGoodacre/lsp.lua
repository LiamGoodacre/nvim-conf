return {
  -- see ../plugins/nvim-lspconfig.lua
  mason_lspconfig = {
    ensure_installed = {
      "hls",
      "lua_ls",
      "purescriptls",
      "ts_ls",
    },
  },
  setup = function()
    -- Yoink lsmod from lazy to load all lsp modules
    require("lazy.core.util").lsmod(
      "LiamGoodacre.lsps",
      function(lsp_module) require(lsp_module).setup() end
    )
  end,
}
