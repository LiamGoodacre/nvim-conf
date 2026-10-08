local M = {}

---@param p vim.pack.PlugData
---@return boolean
local is_active = function(p) return p.active end


---@param p vim.pack.PlugData
---@return boolean
local is_not_active = function(p) return not p.active end


---@param p vim.pack.PlugData
---@return string
local get_spec_name = function(p) return p.spec.name end


---@return Iter
local iter_plugins = function()
  return vim.iter(vim.pack.get(nil, { info = false }))
end


---@param path string
---@return nil|string
local read_file = function(path)
  local fd = io.open(path, "r")
  if not fd then return nil end
  local contents = fd:read("*a")
  fd:close()
  return contents
end


--- Whether a plugin's clone has drifted from its lockfile entry, e.g. after
--- switching config branches: wrong revision checked out or `origin` pointing
--- at a different source. Reads .git directly to keep startup cheap.
---@param p vim.pack.PlugData
---@return boolean
local is_stale = function(p)
  local git_dir = p.path .. "/.git"
  local head = vim.trim(read_file(git_dir .. "/HEAD") or "")
  local config = read_file(git_dir .. "/config") or ""
  local origin = config:match('%[remote "origin"%][^%[]-url%s*=%s*(%S+)')
  return head ~= p.rev or origin ~= p.spec.src
end


--- Checkout lockfile revisions. vim.pack only fixes `origin` when the spec src
--- differs from the lockfile src, so a branch switch that changes both leaves
--- the clone fetching from the old remote; repoint it first.
---@param plugins vim.pack.PlugData[]
local sync = function(plugins)
  vim.iter(plugins):each(function(p)
    vim.system({ "git", "remote", "set-url", "origin", p.spec.src }, { cwd = p.path }):wait()
  end)

  local names = vim.iter(plugins):map(get_spec_name):totable()
  vim.pack.update(names, { target = "lockfile", force = true })
end


--- Runs before plugin/ files are sourced, so stale plugins are fixed first.
M.after_register = function()
  local stale = iter_plugins():filter(is_active):filter(is_stale):totable()
  if #stale == 0 then return end

  vim.notify("Syncing packages to lockfile: " .. vim.iter(stale):map(get_spec_name):join(", "))
  sync(stale)
end


M.after_load = function()

  vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
  end, { desc = "Update packages" })


  vim.api.nvim_create_user_command("PackUpgrade", function()
    vim.pack.update(nil, {force = true})
  end, { desc = "Upgrade packages" })


  vim.api.nvim_create_user_command("PackSync", function()
    sync(iter_plugins():filter(is_active):totable())
  end, { desc = "Sync packages" })


  vim.api.nvim_create_user_command("PackListActive", function()
    local actives =
      iter_plugins()
        :filter(is_active)
        :map(get_spec_name)
        :totable()

    if #actives == 0 then
      vim.notify("No active packages.")
      return
    end

    vim.notify(vim.iter(actives):join("\n"))
  end, { desc = "List active packages" })


  vim.api.nvim_create_user_command("PackListInactive", function()
    local inactives =
      iter_plugins()
        :filter(is_not_active)
        :map(get_spec_name)
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
        :filter(is_not_active)
        :map(get_spec_name)
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
