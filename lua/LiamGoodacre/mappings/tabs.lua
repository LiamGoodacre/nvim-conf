local M = {}

M.setup = function()

  vim.keymap.set("n", "<leader>tn", ":tabn<CR>")
  vim.keymap.set("n", "<leader>tp", ":tabp<CR>")
  vim.keymap.set("n", "<leader>tN", ":tabm +1<CR>")
  vim.keymap.set("n", "<leader>tP", ":tabm -1<CR>")

end

return M
