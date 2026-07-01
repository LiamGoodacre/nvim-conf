local filetype = "cs"

return {
  lsps = {"omnisharp"},
  treesitter_registers = {
    { parser = "c_sharp", filetype = filetype },
  },
  setup = function()
    local exe =
      vim.iter({ "OmniSharp", "omnisharp" })
        :map(vim.fn.exepath)
        :find(function(e) return e ~= "" end)

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
