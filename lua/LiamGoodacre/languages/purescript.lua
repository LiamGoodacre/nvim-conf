return {
  lsps = {"purescriptls"},
  setup = function()
    vim.lsp.config("purescriptls", { filetypes = { "purescript" } })
  end,
}
