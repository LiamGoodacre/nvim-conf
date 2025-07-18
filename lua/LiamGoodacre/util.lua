-- Copied and pruned from "lazy.core.util"

local M = {}

-- Apply fn to each direct module under mod_prefix.
function M.lsmod(mod_prefix, fn)
  local mod_path = vim.fn.stdpath("config") .. "/lua/" .. mod_prefix:gsub("%.", "/")

  local handle = vim.uv.fs_scandir(mod_path)
  while handle do
    local basename, possible_filetype = vim.uv.fs_scandir_next(handle)

    if not basename then
      break
    end

    local filename = mod_path .. "/" .. basename
    local filetype = possible_filetype or vim.uv.fs_stat(filename).type

    if basename == "init.lua" then
      fn(mod_prefix)
    elseif filetype == "file" or filetype == "link" then
      if basename:sub(-4) == ".lua" then
        fn(mod_prefix .. "." .. basename:sub(1, -5))
      end
    elseif filetype == "directory" then
      if vim.uv.fs_stat(filename .. "/init.lua") then
        fn(mod_prefix .. "." .. basename)
      end
    end
  end
end

function M.fold_modules(mod_prefix, fn, start)
  local results = start or {}

  M.lsmod(
    mod_prefix,
    function(language_module)
      for _, entry in ipairs(fn(language_module) or {}) do
        table.insert(results, entry)
      end
    end
  )

  return results
end

-- Require & call .setup() on each direct module under mod_prefix.
function M.setup_modules(mod_prefix)
  M.lsmod(mod_prefix, function (module_name)
    local module = require(module_name)
    if module.setup then
      module.setup()
    end
  end)
end

return M
