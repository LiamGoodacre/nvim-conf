return {
  lsps = {"zls"},
  setup = function()
    -- local zig = "LiamGoodacre-zig"
    local zig = "zig"
    vim.filetype.add({ extension = { zig = zig } })
    vim.treesitter.language.register("zig", zig)
    require("lspconfig").zig.setup({ filetypes = { zig } })
  end,
}
