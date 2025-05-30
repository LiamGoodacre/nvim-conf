return {
  lsps = {"ts_ls"},
  setup = function()
    local typescript = "LiamGoodacre-typescript"
    vim.filetype.add({ extension = { ts = typescript } })
    vim.treesitter.language.register("typescript", typescript)
    require("lspconfig").ts_ls.setup({ filetypes = { typescript } })
  end,
}
