return {
  "goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    require("LiamGoodacre.dashboard").setup(dashboard)
    alpha.setup(dashboard.opts)
  end,
}
