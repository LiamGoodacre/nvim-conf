local M = {}

-- Setup all LiamGoodacre.commands modules
M.setup = function()
  require("LiamGoodacre.util").setup_modules("LiamGoodacre.commands")
end

return M
