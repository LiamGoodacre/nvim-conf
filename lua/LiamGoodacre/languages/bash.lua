return {
  lsps = {'bashls'},
  setup = function()
    local bash = 'LiamGoodacre-bash'
    vim.filetype.add({ extension = { sh = bash } })
    vim.treesitter.language.register('bash', bash)
    require("lspconfig").bashls.setup({ filetypes = { bash } })
  end,
}
