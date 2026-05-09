-- Copied and pruned from "lazy.core.util"

local M = {}

-- Make a strict iterator producing module names under some prefix
function M.find_module_names(mod_prefix)
  local mod_path = vim.fn.stdpath("config") .. "/lua/" .. mod_prefix:gsub("%.", "/")
  local handle = vim.uv.fs_scandir(mod_path)

  local modules = vim.iter(function()
    if handle then
      local basename, possible_filetype = vim.uv.fs_scandir_next(handle)

      if not basename then
        return
      end

      local filename = mod_path .. "/" .. basename
      local filetype = possible_filetype or vim.uv.fs_stat(filename).type

      if basename == "init.lua" then
        return mod_prefix
      elseif filetype == "file" or filetype == "link" then
        if basename:sub(-4) == ".lua" then
          return mod_prefix .. "." .. basename:sub(1, -5)
        end
      elseif filetype == "directory" then
        if vim.uv.fs_stat(filename .. "/init.lua") then
          return mod_prefix .. "." .. basename
        end
      end
    end
  end)

  -- Because non-array iterators don't support flattening/etc
  return vim.iter(modules:totable())
end

function M.require_modules(mod_prefix)
  return M.find_module_names(mod_prefix):map(require)
end

function M.fold_modules(mod_prefix, fn, start)
  return vim.list_extend(start or {},
    M.require_modules(mod_prefix):map(
      function(language_module)
        return fn(language_module) or {}
      end
    ):flatten(1):totable()
  )
end

function M.fold_merge_modules(mod_prefix, fn, start)
  local results = start or {}

  M.require_modules(mod_prefix):each(
    function(language_module)
      results = vim.tbl_deep_extend("force", results, fn(language_module) or {})
    end
  )

  return results
end

-- Require & call .setup() on each direct module under mod_prefix.
function M.setup_modules(mod_prefix)
  M.require_modules(mod_prefix):each(function (module)
    if module.setup then
      module.setup()
    end
  end)
end

return M
