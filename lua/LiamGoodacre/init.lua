local M = {}

M.setup = function()
  local util = require("LiamGoodacre.util")
  util.setup_modules({
    "LiamGoodacre.setting",
    "LiamGoodacre.plugin",
    "LiamGoodacre.theme",
    "LiamGoodacre.tooling",
    "LiamGoodacre.command",
  })
  util.setup_submodules({
    "LiamGoodacre.mappings",
  })
  util.setup_modules({
    "LiamGoodacre.language",
    "LiamGoodacre.dashboard",
  })
end

return M
