return {
  setup = function()
    -- Copied from:
    -- https://github.com/neovim/nvim-lspconfig/blob/216deb2d1b5fbf24398919228208649bbf5cbadf/doc/server_configurations.md#hls
    require("lspconfig").hls.setup({
      filetypes = { "haskell", "lhaskell", "cabal" },
    })
  end,
}
