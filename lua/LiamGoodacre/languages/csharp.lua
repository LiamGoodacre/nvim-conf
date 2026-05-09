return {
  lsps = {"omnisharp"},
  setup = function()
    vim.treesitter.language.register("c_sharp", "cs")

    vim.lsp.config("omnisharp", {
      filetypes = { "cs" },
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
