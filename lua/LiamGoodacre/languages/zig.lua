return {
  lsps = {"zls"},
  setup = function()
    vim.lsp.config("zig", { filetypes = { "zig" } })
  end,
}
