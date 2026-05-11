local M = {}

M.setup = function()

  vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

  vim.keymap.set("n", "<leader>w", ":w<CR>")

  vim.keymap.set("c", "<M-m>", function()
    local cmdtype = vim.fn.getcmdtype()
    if cmdtype ~= "/" and cmdtype ~= "?" then
      return ""
    end

    local win = vim.api.nvim_get_current_win()
    local pos = vim.api.nvim_win_get_cursor(win)
    vim.schedule(function()
      if vim.api.nvim_win_is_valid(win) then
        pcall(vim.api.nvim_win_set_cursor, win, pos)
      end
    end)

    return vim.api.nvim_replace_termcodes("<C-c>", true, false, true)
  end, { expr = true })

end

return M
