local M = {}

function M._demo()
  local function content(char)
    local line = string.rep(char, 5)
    return vim.tbl_map(function() return line end, vim.fn.range(1, 5))
  end

  local chars = {"A", "B", "C", "D", "E"}

  if vim.api.nvim_buf_line_count(0) == 1 and vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == "" then
    vim.api.nvim_buf_set_lines(0, 0, -1, false, content("F"))
  end

  vim.iter(chars)
    :each(function(char)
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, content(char))
      vim.api.nvim_open_win(buf, false, {
        focusable = true,
        split = "left",
      })
    end)

  require("lay").Lay_command()
end


M.setup = function()

  vim.api.nvim_create_user_command("LayDemo", M._demo, {
    desc = "Demo of :Lay"
  })

end

return M
