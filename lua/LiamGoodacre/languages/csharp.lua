local filetype = "cs"

return {
  lsps = {"omnisharp"},
  treesitter_registers = {
    { parser = "c_sharp", filetype = filetype },
  },
  setup = function()
    vim.lsp.config("omnisharp", {
      filetypes = { filetype },
      cmd = {
        vim.fn.exepath("OmniSharp"),
        "-z",
        "--languageserver",
        "--hostPID",
        tostring(vim.fn.getpid()),
      }
    })
  end,
}
