return {
  lsps = {"bashls"},
  setup = function()
    local bash = "LiamGoodacre-bash"
    vim.filetype.add({ extension = { sh = bash } })
    vim.treesitter.language.register("bash", bash)
    vim.lsp.config("bashls", { filetypes = { bash } })
  end,
}
