local filetype = "LiamGoodacre-python"

return {
  lsps = {"pyright"},
  treesitter_registers = {
    { parser = "python", filetype = filetype },
  },
  setup = function()
    -- Python overrides expandtab tabstop=4 softtabstop=4 shiftwidth=4; I don't like that.
    -- https://github.com/neovim/neovim/blob/f1748b78e3165a0821a11f5ae1fb9398aa67c535/runtime/ftplugin/python.vim#L123-L123
    -- (technically not used now because I'm replacing python with LiamGoodacre-python)
    vim.g.python_recommended_style = 0

    vim.filetype.add({ extension = { py = filetype } })
    vim.lsp.config("pyright", { filetypes = { filetype } })
  end,
}
