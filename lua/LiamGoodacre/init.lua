local M = {}

--- Load the top-level config modules in startup order.
M.setup = function()
  require("vim._core.ui2").enable({})

  require("LiamGoodacre.util").setup_modules({
    "LiamGoodacre.setting",
    "LiamGoodacre.plugin",
    "LiamGoodacre.theme",
    "LiamGoodacre.tooling",
    "LiamGoodacre.command",
    "LiamGoodacre.mappings...",
    "LiamGoodacre.language",
    "LiamGoodacre.dashboard",
  })

end

return M
