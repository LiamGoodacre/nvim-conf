local M = {}

M.setup = function()
  local util = require("LiamGoodacre.util")
  util.presetup_modules("LiamGoodacre.plugin_config")
  require("LiamGoodacre.pack").setup()
  util.setup_modules("LiamGoodacre.plugin_config")
end

return M
