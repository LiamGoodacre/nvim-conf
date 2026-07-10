local M = {}

M.before_load = function()
  local grp = vim.api.nvim_create_augroup("tmux_nav_flag", { clear = true })
  vim.api.nvim_create_autocmd({ "VimEnter", "VimResume", "FocusGained" }, {
    group = grp,
    command = "silent !tmux set-option -p @is_vim yes",
  })
  -- tmux config will take care of resetting on pane-focus-out
end


M.plugins = {
  { src = "https://github.com/alexghergh/nvim-tmux-navigation" },
}


M.after_load = function()
  require("nvim-tmux-navigation").setup({})
end

return M
