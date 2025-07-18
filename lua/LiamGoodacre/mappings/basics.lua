local M = {}

M.setup = function()

  vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

  vim.keymap.set("n", "<leader>w", ":w<CR>")

end

return M
