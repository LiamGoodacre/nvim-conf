return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", lazy = false, config = true },
    { "williamboman/mason-lspconfig.nvim", lazy = false },
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "hls",
        "lua_ls",
        "purescriptls",
        "tsserver",
      },
    })
  end,
}
