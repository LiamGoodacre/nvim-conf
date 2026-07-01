local M = {}

M.plugins = {
  { src = "https://github.com/LiamGoodacre/lay.nvim", version = "1" },
}


M.after_load = function()
  require("lay").setup()
end

return M
