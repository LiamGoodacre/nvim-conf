return {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    defaults = {
      mappings = require("LiamGoodacre.mapping").telescope_window_mappings(),
    },
  },
}
