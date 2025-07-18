return {
  lsps = {}, -- {"zls"},
  setup = function()
    if vim.fn.executable("zig") > 0 then
      -- local zig = "LiamGoodacre-zig"
      local zig = "zig"
      vim.filetype.add({ extension = { zig = zig } })
      vim.treesitter.language.register("zig", zig)
      vim.lsp.config("zig", { filetypes = { zig } })
    end
  end,
}
