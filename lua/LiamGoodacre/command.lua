local M = {}

-- Setup all LiamGoodacre.commands modules
M.setup = function()
  require("LiamGoodacre.util").lsmod(
    "LiamGoodacre.commands",
    function(command_module) require(command_module).setup() end
  )
end

return M
