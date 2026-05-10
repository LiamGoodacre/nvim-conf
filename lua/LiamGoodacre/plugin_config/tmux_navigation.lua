local M = {}

function M.after_load()
  require("nvim-tmux-navigation").setup({})
end

return M
