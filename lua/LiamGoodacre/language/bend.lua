local filetype = "LiamGoodacre-bend"

return {
  lsps = {},
  treesitter_registers = {
    { parser = "python", filetype = filetype },
  },
  setup = function()
    vim.filetype.add({ extension = { bend = filetype } })
  end,
}
