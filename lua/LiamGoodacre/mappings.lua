return {
  setup = function()
    vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

    vim.keymap.set("n", "<leader>w", ":w<CR>")

    -- pane navigation
    vim.keymap.set("n", "<C-k>", "<C-w>k")
    vim.keymap.set("n", "<C-l>", "<C-w>l")
    vim.keymap.set("n", "<C-j>", "<C-w>j")
    vim.keymap.set("n", "<C-h>", "<C-w>h")
    vim.keymap.set("n", "<Up>", "<C-w>k")
    vim.keymap.set("n", "<Right>", "<C-w>l")
    vim.keymap.set("n", "<Down>", "<C-w>j")
    vim.keymap.set("n", "<Left>", "<C-w>h")

    -- tab control
    vim.keymap.set("n", "<leader>tn", ":tabn<CR>")
    vim.keymap.set("n", "<leader>tp", ":tabp<CR>")
    vim.keymap.set("n", "<leader>tN", ":tabm +1<CR>")
    vim.keymap.set("n", "<leader>tP", ":tabm -1<CR>")

    -- explore
    vim.keymap.set("n", "<leader>xx", vim.cmd.NvimTreeToggle)
    vim.keymap.set("n", "<leader>xf", vim.cmd.NvimTreeFindFile)
    vim.keymap.set("n", "<leader>xo", vim.cmd.NvimTreeOpen)
    vim.keymap.set("n", "<leader>xc", vim.cmd.NvimTreeClose)

    -- finding things
    local telescope = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
    vim.keymap.set("n", "<leader>gg", telescope.git_files, {})
    vim.keymap.set("n", "<C-space>", telescope.buffers, {})
    vim.keymap.set("n", "<leader>bb", telescope.buffers, {})
    vim.keymap.set("n", "<leader>rg", telescope.live_grep, {})
    vim.keymap.set("n", "<leader>cs", telescope.colorscheme, {})
    vim.keymap.set("n", "<leader>\"p", telescope.registers, {})
    vim.keymap.set("n", "<leader>hk", telescope.keymaps, {})
    vim.keymap.set("n", "<leader><C-o>", telescope.keymaps, {})
    vim.keymap.set("n", "<leader>br", telescope.git_branches, {})
    vim.keymap.set("n", "<leader>ts", telescope.treesitter, {})
    vim.keymap.set("n", "<leader>tt", telescope.builtin, {})
    vim.keymap.set("n", "<leader>lr", telescope.lsp_references, {})
    vim.keymap.set("n", "<leader>lt", telescope.lsp_type_definitions, {})
    vim.keymap.set("n", "<leader>ld", telescope.lsp_definitions, {})

    local function Tsq_command(opts, query, command)
      local bufnr = vim.api.nvim_get_current_buf()
      local parser = vim.treesitter.get_parser(bufnr)
      local tree = parser:parse()[1]
      local root = tree:root()
      local query_obj = vim.treesitter.query.parse(vim.bo.filetype, query)

      local coords = {}
      for _, node in query_obj:iter_captures(root, bufnr, opts.line1 - 1, opts.line2) do
        local start_row, start_col, _, _ = node:range()
        table.insert(coords, {start_row + 1, start_col})
      end

      -- Run the command in reverse order so that the ranges are less likely to change.
      for i = #coords, 1, -1 do
        local start_row, start_col = unpack(coords[i])
        vim.api.nvim_win_set_cursor(0, {start_row, start_col})
        vim.cmd(command)
      end
    end

    vim.api.nvim_create_user_command('Tsq', function(opts)
      local split = vim.split(opts.args, '/', { plain = true, trimempty = true })
      local query = split[1]
      local command = table.concat(split, "/", 2)
      Tsq_command(opts, query, command)
    end, {
      range = true,
      nargs = '+',
      desc = 'Run a command on tree-sitter query matches',
    })

  end,
}
