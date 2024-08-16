require("LiamGoodacre.settings").setup()

local themes = {
  editor = "tokyonight-night",
  status = "tokyonight-night",
}

vim.g.status_theme = themes.status
require("LiamGoodacre.plugins").setup()
vim.cmd.colorscheme(themes.editor)

require("LiamGoodacre.command").setup()

require("LiamGoodacre.mapping").setup()

require("LiamGoodacre.lsp").setup()
