return {
  lsps = {'hls'},
  setup = function()
    local haskell = 'LiamGoodacre-haskell'
    vim.filetype.add({ extension = { hs = haskell, lhs = haskell } })
    vim.treesitter.language.register('haskell', haskell)
    require("lspconfig").hls.setup({ filetypes = { haskell, 'cabal' } })
  end,
}
