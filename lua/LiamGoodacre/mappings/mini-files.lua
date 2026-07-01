local M = {}

M.setup = function()

  local MiniFiles = require("mini.files")
  vim.keymap.set("n", "<leader>mm", MiniFiles.open)

  vim.keymap.set("n", "<leader>mf", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
  end)

end

return M

