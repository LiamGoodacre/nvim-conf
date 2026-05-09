return {
  lsps = {"ts_ls"},
  setup = function()
    vim.lsp.config("ts_ls", { filetypes = { "typescript" } })
  end,
}
