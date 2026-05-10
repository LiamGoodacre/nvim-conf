local M = {}

function M.setup()
  require("telescope").setup({
    defaults = {
      mappings = require("LiamGoodacre.mappings.telescope").telescope_window_mappings(),
    },
  })

  require("telescope").load_extension("ui-select")
end

return M
