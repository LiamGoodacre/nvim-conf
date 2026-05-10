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
        '--hostPID', tostring(vim.fn.getpid()),
        'DotNet:enablePackageRestore=false',
        '--encoding', 'utf-8',
        '--languageserver',
      }
    })
  end,
}
