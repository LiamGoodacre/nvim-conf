local M = {}

--- Copied from normalize_spec in vim.pack
M.nominalise = function(spec)
  local name = spec.name or spec.src:gsub("%.git$", "")
  spec.name = (type(name) == "string" and name or ""):match("[^/]+$") or ""
  return spec
end

M.before_load = function(s) return s.before_load end
M.after_load = function(s) return s.after_load end
M.plugins = function(m) return m.plugins end

--- Run plugin hooks around plugin installation and loading.
M.setup = function()

  local util = require("LiamGoodacre.util")

  util.iter_modules("LiamGoodacre.components...")
    :map(M.before_load)
    :each(util.call)

  ---@type vim.pack.Spec[]
  local plugins =
    util.iter_modules("LiamGoodacre.components...")
      :map(M.plugins)
      :flatten(1)
      :map(M.nominalise)
      :totable()

  -- We do this in 2 steps which makes it more lenient around
  -- plugin interdepedencies & load order.

  -- step 1: tell pack what plugins exist
  vim.pack.add(plugins, { load = false, confirm = false })

  -- step 2: actually load the plugins
  vim.pack.add(plugins, { load = true, confirm = false })

  util.iter_modules("LiamGoodacre.components...")
    :map(M.after_load)
    :each(util.call)

end

return M
