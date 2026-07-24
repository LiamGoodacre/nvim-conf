local M = {}

M.after_load = function()

  vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
  end, { desc = "Update packages" })


  vim.api.nvim_create_user_command("PackUpgrade", function()
    vim.pack.update(nil, {force = true})
  end, { desc = "Upgrade packages" })


  vim.api.nvim_create_user_command("PackListActive", function()
    local actives =
      vim.iter(vim.pack.get())
        :filter(function(p) return p.active end)
        :map(function(p) return p.spec.name end)
        :totable()

    if #actives == 0 then
      vim.notify("No active packages.")
      return
    end

    vim.notify(vim.iter(actives):join("\n"))
  end, { desc = "List active packages" })


  vim.api.nvim_create_user_command("PackListInactive", function()
    local inactives =
      vim.iter(vim.pack.get())
        :filter(function(p) return not p.active end)
        :map(function(p) return p.spec.name end)
        :totable()

    if #inactives == 0 then
      vim.notify("No inactive packages.")
      return
    end

    vim.notify(vim.iter(inactives):join("\n"))
  end, { desc = "List inactive packages" })


  vim.api.nvim_create_user_command("PackPrune", function()
    local inactives =
      vim.iter(vim.pack.get())
        :filter(function(p) return not p.active end)
        :map(function(p) return p.spec.name end)
        :totable()

    if #inactives == 0 then
      vim.notify("No inactive packages")
      return
    end

    vim.ui.select(
      inactives,
      { prompt = "Select inactive package delete" },
      function(selected)
        if not selected then
          vim.notify("No package selected")
          return
        end

        vim.pack.del({ selected })
      end
    )
  end, { desc = "Remove inactive packages" })

end

return M
