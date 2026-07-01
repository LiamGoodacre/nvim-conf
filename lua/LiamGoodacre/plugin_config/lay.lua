local M = {}

M.specs = {
  { src = "https://github.com/LiamGoodacre/lay.nvim", version = "1" },
}


function M.after_load()
  require("lay").setup()
end

return M
