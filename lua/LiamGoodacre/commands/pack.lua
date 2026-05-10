local M = {}

M.setup = function()

  vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
  end, { desc = "Update packages" })


  vim.api.nvim_create_user_command("PackPrune", function()
    local inactives =
      vim.iter(vim.pack.get())
        :filter(function(p) return not p.active end)
        :map(function(p) return p.spec.name end)
        :totable()

    if not inactives then
      vim.notify("No inactive packages")
      return
    end

    vim.ui.select(
      inactives,
      {
        prompt = "Select inactive package delete",
      },
      function(item)
        if item then
          vim.pack.del({ item })
        end
      end
    )
  end, { desc = "Remove inactive packages" })

end

return M
