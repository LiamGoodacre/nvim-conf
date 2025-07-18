local M = {}

M.setup = function()

  vim.keymap.set("n", "<C-k>", "<C-w>k")
  vim.keymap.set("n", "<C-l>", "<C-w>l")
  vim.keymap.set("n", "<C-j>", "<C-w>j")
  vim.keymap.set("n", "<C-h>", "<C-w>h")
  vim.keymap.set("n", "<M-k>", ":<C-U>NvimTmuxNavigateUp<CR>")
  vim.keymap.set("n", "<M-l>", ":<C-U>NvimTmuxNavigateRight<CR>")
  vim.keymap.set("n", "<M-j>", ":<C-U>NvimTmuxNavigateDown<CR>")
  vim.keymap.set("n", "<M-h>", ":<C-U>NvimTmuxNavigateLeft<CR>")
  vim.keymap.set("n", "<Up>", "<C-w>k")
  vim.keymap.set("n", "<Right>", "<C-w>l")
  vim.keymap.set("n", "<Down>", "<C-w>j")
  vim.keymap.set("n", "<Left>", "<C-w>h")

end

return M
