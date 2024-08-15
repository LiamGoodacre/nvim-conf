return {
  setup = function()
    vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

    vim.keymap.set("n", "<leader>w", ":w<CR>")

    -- pane navigation
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

    -- tab control
    vim.keymap.set("n", "<leader>tn", ":tabn<CR>")
    vim.keymap.set("n", "<leader>tp", ":tabp<CR>")
    vim.keymap.set("n", "<leader>tN", ":tabm +1<CR>")
    vim.keymap.set("n", "<leader>tP", ":tabm -1<CR>")

    -- browse
    vim.keymap.set("n", "<leader>bb", vim.cmd.NvimTreeToggle)
    vim.keymap.set("n", "<leader>bf", vim.cmd.NvimTreeFindFile)
    vim.keymap.set("n", "<leader>bo", vim.cmd.NvimTreeOpen)
    vim.keymap.set("n", "<leader>bc", vim.cmd.NvimTreeClose)

    -- finding things
    local telescope = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
    vim.keymap.set("n", "<leader>fh", function() telescope.find_files({ cwd = vim.fn.expand("%:p:h") }) end, {})
    vim.keymap.set("n", "<leader>gg", telescope.git_files, {})
    vim.keymap.set("n", "<leader>gh", function() telescope.git_files({ cwd = vim.fn.expand("%:p:h"), use_git_root = false }) end, {})
    vim.keymap.set("n", "<C-space>", telescope.buffers, {})
    vim.keymap.set("n", "<leader>bl", telescope.buffers, {})
    vim.keymap.set("n", "<leader>rg", telescope.live_grep, {})
    vim.keymap.set("n", "<leader>cs", telescope.colorscheme, {})
    vim.keymap.set("n", "<leader>\"p", telescope.registers, {})
    vim.keymap.set("n", "<leader>hk", telescope.keymaps, {})
    vim.keymap.set("n", "<leader><C-o>", telescope.keymaps, {})
    vim.keymap.set("n", "<leader>gb", telescope.git_branches, {})
    vim.keymap.set("n", "<leader>ts", telescope.treesitter, {})
    vim.keymap.set("n", "<leader>tt", telescope.builtin, {})
    vim.keymap.set("n", "<leader>lr", telescope.lsp_references, {})
    vim.keymap.set("n", "<leader>lt", telescope.lsp_type_definitions, {})
    vim.keymap.set("n", "<leader>ld", telescope.lsp_definitions, {})

    vim.api.nvim_create_user_command('Config', function()
      vim.cmd.cd(vim.fn.stdpath("config") .. "/lua")
      vim.cmd("e LiamGoodacre/init.lua")
      vim.cmd.NvimTreeFindFile()
    end, { desc = 'Open nvim config', })

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

        TSQ_each(opts, function(coord, row, col, command)
          local start_row, start_col, end_row, end_col = unpack(coord)
          hlrange(start_row, start_col, end_row, end_col, "Changed")

          if exec then
            vim.api.nvim_win_set_cursor(0, {row, col})
            if not pcall(vim.cmd(command)) then
              local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
              vim.api.nvim_buf_add_highlight(0, preview_ns, "Underlined", cursor_row - 1, cursor_col, cursor_col + 1)
            else
              vim.api.nvim_buf_add_highlight(0, preview_ns, "Underlined", row - 1, col, col + 1)
            end
          end
        end)

        return 1
      end
    end

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

  end,
}
