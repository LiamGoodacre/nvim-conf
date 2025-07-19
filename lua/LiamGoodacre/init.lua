local M = {}

M.setup = function()
  require("LiamGoodacre.setting").setup()
  require("LiamGoodacre.plugin").setup()
  require("LiamGoodacre.theme").setup()
  require("LiamGoodacre.tooling").setup()
  require("LiamGoodacre.command").setup()
  require("LiamGoodacre.util").setup_modules("LiamGoodacre.mappings")
  require("LiamGoodacre.language").setup()
  require("LiamGoodacre.dashboard").setup()
end

return M
