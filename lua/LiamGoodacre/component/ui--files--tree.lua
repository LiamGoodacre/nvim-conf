local M = {}

M.before_load = function()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end


M.plugins = {
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
}


local on_nvim_tree_attach = function(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- custom
  vim.keymap.set("n", "X",     api.marks.clear,                    opts("Clear marks"))
  vim.keymap.set("n", "x",     api.marks.toggle,                   opts("Toggle mark"))
  vim.keymap.set("n", "g:",    api.node.run.cmd,                   opts("Run Command"))
  vim.keymap.set("n", "<C-v>", api.node.open.vertical,             opts("Open: Vertical Split"))
  vim.keymap.set("n", "<C-s>", api.node.open.horizontal,           opts("Open: Horizontal Split"))
  vim.keymap.set("n", "!",     api.filter.dotfiles.toggle,         opts("Toggle Filter: Dotfiles"))

  -- disabled
  --vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
  --vim.keymap.set("n", "L",     api.node.open.toggle_group_empty,  opts("Toggle Group Empty"))
  --vim.keymap.set("n", "x",     api.fs.cut,                        opts("Cut"))

  -- yet to consider {{{
  vim.keymap.set("n", "<C-]>",          api.tree.change_root_to_node,        opts("CD"))
  vim.keymap.set("n", "<C-k>",          api.node.show_info_popup,            opts("Info"))
  vim.keymap.set("n", "<C-r>",          api.fs.rename_sub,                   opts("Rename: Omit Filename"))
  vim.keymap.set("n", "<C-t>",          api.node.open.tab,                   opts("Open: New Tab"))
  vim.keymap.set("n", "<BS>",           api.node.navigate.parent_close,      opts("Close Directory"))
  vim.keymap.set("n", "<CR>",           api.node.open.edit,                  opts("Open"))
  vim.keymap.set("n", "<Tab>",          api.node.open.preview,               opts("Open Preview"))
  vim.keymap.set("n", ">",              api.node.navigate.sibling.next,      opts("Next Sibling"))
  vim.keymap.set("n", "<",              api.node.navigate.sibling.prev,      opts("Previous Sibling"))
  vim.keymap.set("n", "-",              api.tree.change_root_to_parent,      opts("Up"))
  vim.keymap.set("n", "a",              api.fs.create,                       opts("Create File Or Directory"))
  vim.keymap.set("n", "bd",             api.marks.bulk.delete,               opts("Delete Bookmarked"))
  vim.keymap.set("n", "bt",             api.marks.bulk.trash,                opts("Trash Bookmarked"))
  vim.keymap.set("n", "bmv",            api.marks.bulk.move,                 opts("Move Bookmarked"))
  vim.keymap.set("n", "B",              api.filter.no_buffer.toggle,         opts("Toggle Filter: No Buffer"))
  vim.keymap.set("n", "c",              api.fs.copy.node,                    opts("Copy"))
  vim.keymap.set("n", "C",              api.filter.git.clean.toggle,         opts("Toggle Filter: Git Clean"))
  vim.keymap.set("n", "[c",             api.node.navigate.git.prev,          opts("Prev Git"))
  vim.keymap.set("n", "]c",             api.node.navigate.git.next,          opts("Next Git"))
  vim.keymap.set("n", "d",              api.fs.remove,                       opts("Delete"))
  vim.keymap.set("n", "D",              api.fs.trash,                        opts("Trash"))
  vim.keymap.set("n", "E",              api.tree.expand_all,                 opts("Expand All"))
  vim.keymap.set("n", "e",              api.fs.rename_basename,              opts("Rename: Basename"))
  vim.keymap.set("n", "]e",             api.node.navigate.diagnostics.next,  opts("Next Diagnostic"))
  vim.keymap.set("n", "[e",             api.node.navigate.diagnostics.prev,  opts("Prev Diagnostic"))
  vim.keymap.set("n", "F",              api.filter.live.clear,               opts("Live Filter: Clear"))
  vim.keymap.set("n", "f",              api.filter.live.start,               opts("Live Filter: Start"))
  vim.keymap.set("n", "g?",             api.tree.toggle_help,                opts("Help"))
  vim.keymap.set("n", "gy",             api.fs.copy.absolute_path,           opts("Copy Absolute Path"))
  vim.keymap.set("n", "ge",             api.fs.copy.basename,                opts("Copy Basename"))
  vim.keymap.set("n", "I",              api.filter.git.ignored.toggle,       opts("Toggle Filter: Git Ignore"))
  vim.keymap.set("n", "J",              api.node.navigate.sibling.last,      opts("Last Sibling"))
  vim.keymap.set("n", "K",              api.node.navigate.sibling.first,     opts("First Sibling"))
  vim.keymap.set("n", "o",              api.node.open.edit,                  opts("Open"))
  vim.keymap.set("n", "O",              api.node.open.no_window_picker,      opts("Open: No Window Picker"))
  vim.keymap.set("n", "p",              api.fs.paste,                        opts("Paste"))
  vim.keymap.set("n", "P",              api.node.navigate.parent,            opts("Parent Directory"))
  vim.keymap.set("n", "q",              api.tree.close,                      opts("Close"))
  vim.keymap.set("n", "r",              api.fs.rename,                       opts("Rename"))
  vim.keymap.set("n", "R",              api.tree.reload,                     opts("Refresh"))
  vim.keymap.set("n", "s",              api.node.run.system,                 opts("Run System"))
  vim.keymap.set("n", "S",              api.tree.search_node,                opts("Search"))
  vim.keymap.set("n", "u",              api.fs.rename_full,                  opts("Rename: Full Path"))
  vim.keymap.set("n", "U",              api.filter.custom.toggle,            opts("Toggle Filter: Hidden"))
  vim.keymap.set("n", "W",              api.tree.collapse_all,               opts("Collapse"))
  vim.keymap.set("n", "y",              api.fs.copy.filename,                opts("Copy Name"))
  vim.keymap.set("n", "Y",              api.fs.copy.relative_path,           opts("Copy Relative Path"))
  vim.keymap.set("n", "<2-LeftMouse>",  api.node.open.edit,                  opts("Open"))
  vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node,        opts("CD"))
  -- }}} yet to consider

end


M.after_load = function()
  require("nvim-tree").setup({
    on_attach = on_nvim_tree_attach,
    filters = {
      enable = true,
      dotfiles = true,
    },
    renderer = {
      hidden_display = "simple",
    },
    view = {
      width = 48,
      side = "left",
      number = true,
      relativenumber = true,
      float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
          relative = "cursor",
          border = "rounded",
          width = 60,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    },
  })

  vim.keymap.set("n", "<leader>bb", vim.cmd.NvimTreeToggle)
  vim.keymap.set("n", "<leader>bf", vim.cmd.NvimTreeFindFile)
  vim.keymap.set("n", "<leader>bo", vim.cmd.NvimTreeOpen)
  vim.keymap.set("n", "<leader>bc", vim.cmd.NvimTreeClose)

end

return M
