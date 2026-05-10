vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      on_attach = require("LiamGoodacre.mappings.nvim-tree").on_nvim_tree_attach,
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
  end,
}
