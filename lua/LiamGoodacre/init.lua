local M = {}

--- Load the top-level config modules in startup order.
M.setup = function()
  require("vim._core.ui2").enable({})

  require("LiamGoodacre.util").setup_modules({
    "LiamGoodacre.setting",
    "LiamGoodacre.component",
    "LiamGoodacre.command",
    "LiamGoodacre.mappings...",
    "LiamGoodacre.language",
  })

end

return M
