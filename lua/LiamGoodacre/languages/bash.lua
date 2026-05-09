local bash = "bash"
local sh = "sh"

return {
  lsps = {"bashls"},
  treesitter_filetypes = { sh },
  setup = function()
    vim.treesitter.language.register(bash, sh)
    vim.lsp.config("bashls", { filetypes = { bash, sh } })
  end,
}
