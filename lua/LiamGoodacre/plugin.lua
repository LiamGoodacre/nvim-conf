local M = {}

--- Copied from normalize_spec in vim.pack
function M.nominalise(spec)
  local name = spec.name or spec.src:gsub("%.git$", "")
  spec.name = (type(name) == "string" and name or ""):match("[^/]+$") or ""
  return spec
end

function M.before_load(s) return s.before_load end
function M.after_load(s) return s.after_load end
function M.specs(m) return m.specs end

--- Run plugin hooks around plugin installation and loading.
M.setup = function()

  local util = require("LiamGoodacre.util")

  util.iter_modules("LiamGoodacre.plugin_config...")
    :map(M.before_load)
    :each(util.call)

  ---@type vim.pack.Spec[]
  local specs =
    util.iter_modules("LiamGoodacre.plugin_config...")
      :map(M.specs)
      :flatten(1)
      :map(M.nominalise)
      :totable()

  -- We do this in 2 steps which makes it more lenient around
  -- plugin interdepedencies & load order.

  -- step 1: tell pack what plugins exist
  vim.pack.add(specs, { load = false, confirm = false })

  -- step 2: actually load the plugins
  vim.pack.add(specs, { load = true, confirm = false })

  util.iter_modules("LiamGoodacre.plugin_config...")
    :map(M.after_load)
    :each(util.call)

end

return M
