return {
  lsps = {"omnisharp"},
  setup = function()
    local cs = "LiamGoodacre-cs"
    vim.filetype.add({ extension = { cs = cs } })
    vim.treesitter.language.register("c_sharp", cs)

    require("lspconfig").omnisharp.setup({
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
