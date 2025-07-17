return {
  "goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    require("LiamGoodacre.dashboard").configure(dashboard)
    alpha.setup(dashboard.opts)
  end,
}
