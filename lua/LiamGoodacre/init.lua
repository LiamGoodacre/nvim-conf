require("LiamGoodacre.settings").setup()

local themes = {
  main = "tokyonight-moon",
  status = "iceberg",
}

vim.g.status_theme = themes.status
require("LiamGoodacre.plugins").setup()
vim.cmd.colorscheme(themes.main)

require("LiamGoodacre.mappings").setup()

-- Yoink lsmod from lazy to load all lsp modules
require("lazy.core.util").lsmod("LiamGoodacre.lsp", function(lsp_module) require(lsp_module).setup() end)
