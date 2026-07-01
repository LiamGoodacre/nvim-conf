local M = {}

--- Load the top-level config modules in startup order.
M.setup = function()
  require("vim._core.ui2").enable({})

  require("LiamGoodacre.util").setup_modules({
    "LiamGoodacre.settings",
    "LiamGoodacre.components",
    "LiamGoodacre.commands",
    "LiamGoodacre.mappings...",
    "LiamGoodacre.languages",
  })

end

return M
