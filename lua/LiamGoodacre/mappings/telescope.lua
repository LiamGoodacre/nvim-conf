local M = {}

M.telescope_window_mappings = function()
  return {
    i = {
      [""] = require("telescope.actions.layout").toggle_preview, -- AKA Ctrl-/
    },
  }
end

M.setup = function()

  local telescope = require("telescope.builtin")
  vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
  vim.keymap.set("n", "<leader>fh", function() telescope.find_files({ cwd = vim.fn.expand("%:p:h") }) end, {})
  vim.keymap.set("n", "<leader>gg", telescope.git_files, {})
  vim.keymap.set("n", "<leader>gh", function() telescope.git_files({ cwd = vim.fn.expand("%:p:h"), use_git_root = false }) end, {})
  vim.keymap.set("n", "<C-space>", telescope.buffers, {})
  vim.keymap.set("n", "<leader>bl", telescope.buffers, {})
  vim.keymap.set("n", "<leader>rg", telescope.live_grep, {})
  vim.keymap.set("n", "<leader>\"p", telescope.registers, {})
  vim.keymap.set("n", "<leader>hk", telescope.keymaps, {})
  vim.keymap.set("n", "<leader><C-o>", telescope.keymaps, {})
  vim.keymap.set("n", "<leader>gb", telescope.git_branches, {})
  vim.keymap.set("n", "<leader>ts", telescope.treesitter, {})
  vim.keymap.set("n", "<leader>tt", telescope.builtin, {})
  vim.keymap.set("n", "<leader>lw", telescope.lsp_references, {})
  vim.keymap.set("n", "<leader>lt", telescope.lsp_type_definitions, {})
  vim.keymap.set("n", "<leader>ld", telescope.lsp_definitions, {})
  vim.keymap.set("n", "<leader>le", telescope.diagnostics, {})
  vim.keymap.set("i", "<C-s>", telescope.symbols, {})
  vim.keymap.set("n", "<leader><tab>", telescope.resume, {})
  vim.keymap.set("n", "<leader>g]", require("LiamGoodacre.commands.teletag").teletag, { desc = "Telescope jump to exact tag matches" })

end

return M
