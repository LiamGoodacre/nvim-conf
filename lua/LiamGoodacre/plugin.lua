local M = {}

M.setup = function()
  local pack = require("LiamGoodacre.pack")

  require("LiamGoodacre.plugin_config.copilot").before_load()
  require("LiamGoodacre.plugin_config.nvim_tree").before_load()

  pack.setup_hooks()
  pack.add()
  pack.load()
  pack.run_hooks()

  require("LiamGoodacre.plugin_config.tmux_navigation").setup()
  require("LiamGoodacre.plugin_config.nvim_tree").setup()
  require("LiamGoodacre.plugin_config.telescope").setup()
end

return M
