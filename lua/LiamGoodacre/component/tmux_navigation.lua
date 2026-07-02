local M = {}

M.plugins = {
  { src = "https://github.com/alexghergh/nvim-tmux-navigation" },
}


M.after_load = function()
  require("nvim-tmux-navigation").setup({})
end

return M
