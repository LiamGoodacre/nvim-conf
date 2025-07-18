local M = {}

M.setup = function()

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

end

return M
