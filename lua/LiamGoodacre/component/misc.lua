local M = {}

M.before_load = function()

  vim.cmd.packadd("nvim.undotree")

end


M.plugins = {
  { src = "https://github.com/neovim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim-treesitter/treesitter-parser-registry" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
}

return M
