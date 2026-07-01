local M = {}

M.before_load = function()
  vim.g.copilot_enabled = false
  vim.g.copilot_no_tab_map = true
  vim.g.copilot_no_maps = true
end


M.plugins = {
  { src = "https://github.com/github/copilot.vim" },
}

return M
