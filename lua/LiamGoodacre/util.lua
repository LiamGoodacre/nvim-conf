local M = {}

--- Call a function with no arguments.
---@param f function
function M.call(f)
  return f()
end


--- Mutate lhs by overwriting entries from rhs.
---@param lhs table
---@param rhs table
---@return table
function M.table_merge_rtl(lhs, rhs)
  return vim.tbl_deep_extend("force", lhs or {}, rhs or {})
end


--- Iterator via uv.fs_scandir & uv.fs_scandir_next
---@param path string
---@return Iter
function M.iter_dir(path)
  local handle = vim.uv.fs_scandir(path)
  return vim.iter(function()
    if handle then
      local basename, possible_filetype = vim.uv.fs_scandir_next(handle)
      if not basename then return end
      local filetype =
        possible_filetype or
        vim.uv.fs_stat(path .. "/" .. basename).type
      return basename, filetype
    end
  end)
end


--- Build a config path from a module prefix
---@param mod_prefix string
---@return string
function M.module_prefix_to_path(mod_prefix)
  return vim.fn.stdpath("config") .. "/lua/" .. mod_prefix:gsub("%.", "/")
end


--- Given a module prefix produce a function for converting the defined output
--- of 'uv.fs_scandir_next' into a module file path which could be 'require'd.
---@param mod_prefix string
---@return fun(basename: string, filetype: nil|string): nil|string
function M.resolve_module_file_name(mod_prefix)
  local mod_path = M.module_prefix_to_path(mod_prefix)

  ---@param basename string
  ---@param filetype nil|string
  ---@return nil|string
  return function(basename, filetype)
    local filename = mod_path .. "/" .. basename

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
end


--- Given a "module specifier" return an array of module file paths.
--- If the specifier ends in "..." then we look up direct submodules.
--- Otherwise we treat the specifier as a literal module name.
---@param module_specifier string
---@return table table array of module file paths
function M.resolve_modules_to_paths(module_specifier)
  if module_specifier:sub(-3) ~= "..." then
    return {module_specifier}
  end

  local module_prefix = module_specifier:sub(1, -4)
  return M.iter_dir(M.module_prefix_to_path(module_prefix))
    :map(M.resolve_module_file_name(module_prefix))
    :totable()
end


--- Iterator that requires modules matching a "module specifier".
---@see |M.resolve_modules_to_paths|
---@param ... string|string[]
---@return Iter
function M.iter_modules(...)
  return vim.iter({...}):flatten(1)
    :map(M.resolve_modules_to_paths):flatten(1)
    :map(require)
end


--- Require & call .setup() modules matching a "module specifier".
---@param ... string|string[]
---@return nil
function M.setup_modules(...)
  M.iter_modules(...)
    :map(function(m) return m.setup end)
    :each(M.call)
end

return M
