return {
  lsps = {"zls"},
  setup = function()
    -- local zig = "LiamGoodacre-zig"
    local zig = "zig"
    vim.filetype.add({ extension = { zig = zig } })
    vim.treesitter.language.register("zig", zig)
    vim.lsp.config("zig", { filetypes = { zig } })
  end,
}
