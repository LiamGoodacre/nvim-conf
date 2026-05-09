return {
  lsps = {"bashls"},
  treesitter_registers = {
    { parser = "bash", filetype = "sh" },
  },
  setup = function()
    vim.lsp.config("bashls", { filetypes = { "bash", "sh" } })
  end,
}
