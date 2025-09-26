return {
  lsps = {"ts_ls"},
  setup = function()
    local typescript = "LiamGoodacre-typescript"
    vim.filetype.add({ extension = { ts = typescript } })
    vim.treesitter.language.register("typescript", typescript)
    vim.lsp.config("ts_ls", { filetypes = { typescript } })
  end,
}
