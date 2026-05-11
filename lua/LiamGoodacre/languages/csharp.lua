local filetype = "cs"

return {
  lsps = {"omnisharp"},
  treesitter_registers = {
    { parser = "c_sharp", filetype = filetype },
  },
  setup = function()
    local exe = vim.fn.exepath("OmniSharp") or vim.fn.exepath("omnisharp")
    if exe then
      vim.lsp.config("omnisharp", {
        filetypes = { filetype },
        cmd = {
          exe,
          "-z",
          "--hostPID", tostring(vim.fn.getpid()),
          "DotNet:enablePackageRestore=false",
          "--encoding", "utf-8",
          "--languageserver",
        }
      })
    end
  end,
}
