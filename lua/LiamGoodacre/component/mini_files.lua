local M = {}

M.plugins = {
  { src = 'https://github.com/nvim-mini/mini.files', version = 'stable' },
}


M.after_load = function()
  local MiniFiles = require('mini.files')

  MiniFiles.setup({
    -- Customization of shown content
    content = {
      -- Predicate for which file system entries to show
      filter = nil,
      -- Highlight group to use for a file system entry
      highlight = nil,
      -- Prefix text and highlight to show to the left of file system entry
      prefix = nil,
      -- Order in which to show file system entries
      sort = nil,
    },

    -- Module mappings created only inside explorer.
    -- Use `''` (empty string) to not create one.
    mappings = {
      close       = '<C-[>',
      go_in       = 'l',
      go_in_plus  = '<C-m>',
      go_out      = 'h',
      go_out_plus = nil,
      mark_goto   = "'",
      mark_set    = 'm',
      reset       = '<BS>',
      reveal_cwd  = '@',
      show_help   = 'g?',
      synchronize = '=',
      trim_left   = '<',
      trim_right  = '>',
    },

    -- General options
    options = {
      -- Whether to delete permanently or move into module-specific trash
      permanent_delete = true,
      -- Whether to use for editing directories
      use_as_default_explorer = true,
      -- Timeout for synchronous LSP integration requests
      lsp_timeout = 1000,
    },

    -- Customization of explorer windows
    windows = {
      -- Maximum number of windows to show side by side
      max_number = math.huge,
      -- Whether to show preview of file/directory under cursor
      preview = false,
      -- Width of focused window
      width_focus = 50,
      -- Width of non-focused window
      width_nofocus = 15,
      -- Width of preview window
      width_preview = 25,
    },
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowUpdate',
    callback = function(args)
      local win_id = args.data.win_id
      local win_opt = vim.wo[win_id]
      win_opt.number = true
      win_opt.relativenumber = true
    end,
  })

  vim.keymap.set("n", "<leader>mm", MiniFiles.open)

  vim.keymap.set("n", "<leader>mf", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
  end)

end

return M
