local cs = "cs"
local c_sharp = "c_sharp"

return {
  lsps = {"omnisharp"},
  treesitter_filetypes = { cs },
  setup = function()
    vim.treesitter.language.register(c_sharp, cs)

    vim.lsp.config("omnisharp", {
      filetypes = { cs },
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
