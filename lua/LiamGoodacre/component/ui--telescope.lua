local M = {}

M.plugins = {
  { src = "https://github.com/nvim-telescope/telescope-symbols.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim", version = vim.version.range("*"), },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
}


M.after_load = function()

  require("telescope").setup({
    defaults = {
      mappings = require("LiamGoodacre.mappings.telescope").telescope_window_mappings(),
    },
  })

  require("telescope").load_extension("ui-select")

end

return M
