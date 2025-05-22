return {
  setup = function()

    vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

    vim.keymap.set("n", "<leader>w", ":w<CR>")

    -- pane navigation {{{
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
    -- }}} pane navigation

    -- tab control {{{
    vim.keymap.set("n", "<leader>tn", ":tabn<CR>")
    vim.keymap.set("n", "<leader>tp", ":tabp<CR>")
    vim.keymap.set("n", "<leader>tN", ":tabm +1<CR>")
    vim.keymap.set("n", "<leader>tP", ":tabm -1<CR>")
    -- }}} tab control

    -- browse {{{
    vim.keymap.set("n", "<leader>bb", vim.cmd.NvimTreeToggle)
    vim.keymap.set("n", "<leader>bf", vim.cmd.NvimTreeFindFile)
    vim.keymap.set("n", "<leader>bo", vim.cmd.NvimTreeOpen)
    vim.keymap.set("n", "<leader>bc", vim.cmd.NvimTreeClose)
    -- }}} browse

    -- finding things {{{
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
    vim.keymap.set("n", "<leader>le", telescope.diagnostics, {})
    vim.keymap.set("i", "<C-s>", telescope.symbols, {})
    vim.keymap.set("n", "<leader><tab>", telescope.resume, {})
    vim.keymap.set("n", "<leader>g]", require("LiamGoodacre.commands.teletag").teletag, { desc = "Telescope jump to exact tag matches" })
    -- }}} finding things

    -- harpoon {{{
    local harpoon = require("harpoon")
    vim.keymap.set("n", "<leader>P", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<leader>N", function() harpoon:list():next() end)
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

    -- basic telescope configuration
    local telescope_config = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = telescope_config.file_previewer({}),
        sorter = telescope_config.generic_sorter({}),
      }):find()
    end

    vim.keymap.set("n", "<leader>hh", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
    vim.keymap.set("n", "<leader>h2", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    -- }}} harpoon

    -- editing configuration {{{
    vim.api.nvim_create_user_command('Config', function()
      vim.cmd.cd(vim.fn.stdpath("config") .. "/lua")
      vim.cmd("e LiamGoodacre/init.lua")
      vim.cmd.NvimTreeFindFile()
    end, { desc = 'Open nvim config', })

    vim.api.nvim_create_user_command('ConfigTmux', function()
      vim.cmd.cd(vim.fn.stdpath("config") .. "/../tmux-conf")
      vim.cmd("e .tmux.conf")
    end, { desc = 'Open tmux config', })

    vim.api.nvim_create_user_command('ConfigTerm', function()
      vim.cmd.cd(vim.fn.stdpath("config") .. "/../alacritty-conf")
      vim.cmd("e .alacritty.toml")
    end, { desc = 'Open terminal config', })
    -- }}} editing configuration

  end,

  telescope_window_mappings = function()
    return {
      i = {
        [""] = require("telescope.actions.layout").toggle_preview, -- AKA Ctrl-/
      },
    }
  end,

  on_nvim_tree_attach = function(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- custom
    vim.keymap.set('n', 'X',     api.tree.toggle_no_bookmark_filter, opts('Toggle Filter: No Bookmark'))
    vim.keymap.set('n', 'x',     api.marks.toggle,                   opts('Toggle Bookmark'))
    vim.keymap.set('n', 'g:',    api.node.run.cmd,                   opts('Run Command'))
    vim.keymap.set('n', '<C-s>', api.node.open.vertical,             opts('Open: Vertical Split'))
    vim.keymap.set('n', '<C-v>', api.node.open.horizontal,           opts('Open: Horizontal Split'))
    vim.keymap.set('n', '!',     api.tree.toggle_hidden_filter,      opts('Toggle Filter: Dotfiles'))

    -- disabled
    --vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
    --vim.keymap.set('n', 'L',     api.node.open.toggle_group_empty,  opts('Toggle Group Empty'))
    --vim.keymap.set('n', 'x',     api.fs.cut,                        opts('Cut'))

    -- yet to consider {{{
    vim.keymap.set('n', '<C-]>',          api.tree.change_root_to_node,        opts('CD'))
    vim.keymap.set('n', '<C-k>',          api.node.show_info_popup,            opts('Info'))
    vim.keymap.set('n', '<C-r>',          api.fs.rename_sub,                   opts('Rename: Omit Filename'))
    vim.keymap.set('n', '<C-t>',          api.node.open.tab,                   opts('Open: New Tab'))
    vim.keymap.set('n', '<BS>',           api.node.navigate.parent_close,      opts('Close Directory'))
    vim.keymap.set('n', '<CR>',           api.node.open.edit,                  opts('Open'))
    vim.keymap.set('n', '<Tab>',          api.node.open.preview,               opts('Open Preview'))
    vim.keymap.set('n', '>',              api.node.navigate.sibling.next,      opts('Next Sibling'))
    vim.keymap.set('n', '<',              api.node.navigate.sibling.prev,      opts('Previous Sibling'))
    vim.keymap.set('n', '-',              api.tree.change_root_to_parent,      opts('Up'))
    vim.keymap.set('n', 'a',              api.fs.create,                       opts('Create File Or Directory'))
    vim.keymap.set('n', 'bd',             api.marks.bulk.delete,               opts('Delete Bookmarked'))
    vim.keymap.set('n', 'bt',             api.marks.bulk.trash,                opts('Trash Bookmarked'))
    vim.keymap.set('n', 'bmv',            api.marks.bulk.move,                 opts('Move Bookmarked'))
    vim.keymap.set('n', 'B',              api.tree.toggle_no_buffer_filter,    opts('Toggle Filter: No Buffer'))
    vim.keymap.set('n', 'c',              api.fs.copy.node,                    opts('Copy'))
    vim.keymap.set('n', 'C',              api.tree.toggle_git_clean_filter,    opts('Toggle Filter: Git Clean'))
    vim.keymap.set('n', '[c',             api.node.navigate.git.prev,          opts('Prev Git'))
    vim.keymap.set('n', ']c',             api.node.navigate.git.next,          opts('Next Git'))
    vim.keymap.set('n', 'd',              api.fs.remove,                       opts('Delete'))
    vim.keymap.set('n', 'D',              api.fs.trash,                        opts('Trash'))
    vim.keymap.set('n', 'E',              api.tree.expand_all,                 opts('Expand All'))
    vim.keymap.set('n', 'e',              api.fs.rename_basename,              opts('Rename: Basename'))
    vim.keymap.set('n', ']e',             api.node.navigate.diagnostics.next,  opts('Next Diagnostic'))
    vim.keymap.set('n', '[e',             api.node.navigate.diagnostics.prev,  opts('Prev Diagnostic'))
    vim.keymap.set('n', 'F',              api.live_filter.clear,               opts('Live Filter: Clear'))
    vim.keymap.set('n', 'f',              api.live_filter.start,               opts('Live Filter: Start'))
    vim.keymap.set('n', 'g?',             api.tree.toggle_help,                opts('Help'))
    vim.keymap.set('n', 'gy',             api.fs.copy.absolute_path,           opts('Copy Absolute Path'))
    vim.keymap.set('n', 'ge',             api.fs.copy.basename,                opts('Copy Basename'))
    vim.keymap.set('n', 'I',              api.tree.toggle_gitignore_filter,    opts('Toggle Filter: Git Ignore'))
    vim.keymap.set('n', 'J',              api.node.navigate.sibling.last,      opts('Last Sibling'))
    vim.keymap.set('n', 'K',              api.node.navigate.sibling.first,     opts('First Sibling'))
    vim.keymap.set('n', 'o',              api.node.open.edit,                  opts('Open'))
    vim.keymap.set('n', 'O',              api.node.open.no_window_picker,      opts('Open: No Window Picker'))
    vim.keymap.set('n', 'p',              api.fs.paste,                        opts('Paste'))
    vim.keymap.set('n', 'P',              api.node.navigate.parent,            opts('Parent Directory'))
    vim.keymap.set('n', 'q',              api.tree.close,                      opts('Close'))
    vim.keymap.set('n', 'r',              api.fs.rename,                       opts('Rename'))
    vim.keymap.set('n', 'R',              api.tree.reload,                     opts('Refresh'))
    vim.keymap.set('n', 's',              api.node.run.system,                 opts('Run System'))
    vim.keymap.set('n', 'S',              api.tree.search_node,                opts('Search'))
    vim.keymap.set('n', 'u',              api.fs.rename_full,                  opts('Rename: Full Path'))
    vim.keymap.set('n', 'U',              api.tree.toggle_custom_filter,       opts('Toggle Filter: Hidden'))
    vim.keymap.set('n', 'W',              api.tree.collapse_all,               opts('Collapse'))
    vim.keymap.set('n', 'y',              api.fs.copy.filename,                opts('Copy Name'))
    vim.keymap.set('n', 'Y',              api.fs.copy.relative_path,           opts('Copy Relative Path'))
    vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,                  opts('Open'))
    vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node,        opts('CD'))
    -- }}} yet to consider

  end,
}
