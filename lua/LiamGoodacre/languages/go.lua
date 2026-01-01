return {
  lsps = {"gopls"},
  setup = function()
    vim.lsp.config("gopls", {
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
