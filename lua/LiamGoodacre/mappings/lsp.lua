local M = {}

M.setup = function()

  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
  vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })

end

return M
