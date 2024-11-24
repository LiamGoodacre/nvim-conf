return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- transparent = true,
    styles = {
      sidebars = "dark",
      floats = "dark",
    },
    on_highlights = require("LiamGoodacre.theme").highlights,
  },
}
