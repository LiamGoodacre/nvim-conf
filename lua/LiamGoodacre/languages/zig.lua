return {
  lsps = {}, -- {"zls"},
  setup = function()
    if vim.fn.executable("zig") > 0 then
      -- local zig = "LiamGoodacre-zig"
      local zig = "zig"
      vim.filetype.add({ extension = { zig = zig } })
      vim.treesitter.language.register("zig", zig)
      require("lspconfig").zig.setup({ filetypes = { zig } })
    end
  end,
}
