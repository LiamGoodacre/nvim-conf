return {
  lsps = {"bashls"},
  setup = function()
    vim.treesitter.language.register("bash", "sh")
    vim.lsp.config("bashls", { filetypes = { "bash", "sh" } })
  end,
}
