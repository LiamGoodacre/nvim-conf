return {
  lsps = {"purescriptls"},
  setup = function()
    local purescript = "LiamGoodacre-purescript"
    vim.filetype.add({ extension = { purs = purescript } })
    vim.treesitter.language.register("purescript", purescript)
    require("lspconfig").purescriptls.setup({ filetypes = { purescript } })
  end,
}
