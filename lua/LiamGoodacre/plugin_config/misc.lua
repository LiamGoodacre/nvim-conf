local M = {}

function M.before_load()

  vim.cmd.packadd("nvim.undotree")

end

M.specs = {
  { src = "https://github.com/goolord/alpha-nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim-treesitter/treesitter-parser-registry" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/smjonas/live-command.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
}

return M
