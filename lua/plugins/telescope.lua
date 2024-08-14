return {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    defaults = {
      mappings = {
        i = {
          [""] = require("telescope.actions.layout").toggle_preview,
        },
      },
    },
  },
}
