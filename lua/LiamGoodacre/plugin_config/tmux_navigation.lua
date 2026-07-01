local M = {}

M.specs = {
  { src = "https://github.com/alexghergh/nvim-tmux-navigation" },
}


function M.after_load()
  require("nvim-tmux-navigation").setup({})
end

return M
