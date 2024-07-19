require("LiamGoodacre.settings").setup()

local themes = {
  main = "tokyonight-night",
  status = "iceberg",
}

vim.g.status_theme = themes.status
require("LiamGoodacre.plugins").setup()
vim.cmd.colorscheme(themes.main)

require("LiamGoodacre.mappings").setup()

require("LiamGoodacre.lsps").setup()
