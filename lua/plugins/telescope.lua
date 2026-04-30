return {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-symbols.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    require("telescope").setup({
      defaults = {
        mappings = require("LiamGoodacre.mappings.telescope").telescope_window_mappings(),
      },
    })

    require("telescope").load_extension("ui-select")
  end,
}
