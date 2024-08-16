
local function TSQ_each(opts, op)
  local split = vim.split(opts.args, '/', { plain = true, trimempty = true })
  local which_end = split[1]
  local query = split[2]
  local rest = table.concat(split, "/", 3)

  local parser = vim.treesitter.get_parser(0)
  local tree = parser:parse()[1]
  local root = tree:root()
  local query_obj = vim.treesitter.query.parse(vim.bo.filetype, query)

  local coords = {}
  for _, node in query_obj:iter_captures(root, 0, opts.line1 - 1, opts.line2) do
    local start_row, start_col, end_row, end_col = node:range()
    table.insert(coords, {start_row + 1, start_col, end_row + 1, end_col - 1})
  end

  -- Run the rest in reverse order so that the ranges are less likely to change.
  for i = #coords, 1, -1 do
    local start_row, start_col, end_row, end_col = unpack(coords[i])
    local row, col
    if which_end == "e" or which_end == "$" then
      row, col = end_row, end_col
    else
      row, col = start_row, start_col
    end
    op(coords[i], row, col, rest)
  end
end

local function TSQ_command(opts)
  TSQ_each(opts, function(_, row, col, command)
    vim.api.nvim_win_set_cursor(0, {row, col})
    vim.cmd(command)
  end)
end

local function TSQ_command_preview(exec)
  return function (opts, preview_ns)
    local function hlrange(row1, col1, row2, col2, hlgroup)
      if row1 > row2 or (row1 == row2 and col1 > col2) then
        row1, col1, row2, col2 = row2, col2, row1, col1
      end

      if row1 == row2 then
        vim.api.nvim_buf_add_highlight(0, preview_ns, hlgroup, row1 - 1, col1, col2 + 1)
      else
        vim.api.nvim_buf_add_highlight(0, preview_ns, hlgroup, row1 - 1, col1, -1)
        for i = row1 + 1, row2 - 1 do
          vim.api.nvim_buf_add_highlight(0, preview_ns, hlgroup, i - 1, 0, -1)
        end
        vim.api.nvim_buf_add_highlight(0, preview_ns, hlgroup, row2 - 1, 0, col2 + 1)
      end
    end

    local function cursorat(row, col)
      vim.api.nvim_buf_add_highlight(0, preview_ns, "Underlined", row - 1, col, col + 1)
    end

    TSQ_each(opts, function(coord, row, col, command)
      local start_row, start_col, end_row, end_col = unpack(coord)
      hlrange(start_row, start_col, end_row, end_col, "Changed")

      if exec then
        vim.api.nvim_win_set_cursor(0, {row, col})
        if not pcall(vim.cmd(command)) then
          local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
          cursorat(cursor_row, cursor_col)
        else
          cursorat(row, col)
        end
      else
        cursorat(row, col)
      end
    end)

    return 1
  end
end

local function setup()
  vim.api.nvim_create_user_command('TSQ', TSQ_command, {
    range = true,
    nargs = '+',
    desc = 'Run a command on tree-sitter query matches',
    preview = TSQ_command_preview(false),
  })

  vim.api.nvim_create_user_command('TSQx', TSQ_command, {
    range = true,
    nargs = '+',
    desc = 'Run a command on tree-sitter query matches (previewing the command)',
    preview = TSQ_command_preview(true),
  })
end

return {
  TSQ_each = TSQ_each,
  TSQ_command = TSQ_command,
  TSQ_command_preview = TSQ_command_preview,
  setup = setup,
}
