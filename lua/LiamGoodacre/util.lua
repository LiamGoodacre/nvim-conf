local M = {}

--- Iterator via uv.fs_scandir & uv.fs_scandir_next
---@param path string
---@return Iter
function M.iter_dir(path)
  local handle = vim.uv.fs_scandir(path)
  return vim.iter(function()
    if handle then
      local basename, possible_filetype = vim.uv.fs_scandir_next(handle)
      if not basename then return end
      return basename, possible_filetype
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
---@return fun(basename: string, possible_filetype: nil|string): nil|string
function M.resolve_module_file_name(mod_prefix)
  local mod_path = M.module_prefix_to_path(mod_prefix)

  ---@param basename string
  ---@param possible_filetype nil|string
  ---@return nil|string
  return function(basename, possible_filetype)
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
end


--- Scan for module names directly under some prefix
---@param mod_prefix string
---@return table table array of module names
function M.find_module_names(mod_prefix)
  return M.iter_dir(M.module_prefix_to_path(mod_prefix))
    :map(M.resolve_module_file_name(mod_prefix))
    :totable()
end


--- Make an iterator of required modules under some prefix
---@param mod_prefix string
---@return Iter
function M.iter_modules(mod_prefix)
  return vim.iter(M.find_module_names(mod_prefix))
    :map(require)
end


--- Mutate lhs by overwriting entries from rhs.
---@param lhs table
---@param rhs table
---@return table
function M.table_merge_rtl(lhs, rhs)
  return vim.tbl_deep_extend("force", lhs or {}, rhs or {})
end


---@class SetupModule
---@field setup nil|fun()

--- Call .setup() on a module if it exists
---@param module SetupModule
---@return nil
function M.call_setup(module)
  if module.setup then
    module.setup()
  end
end


--- Require & call .setup() on each direct module under mod_prefix.
---@param mod_prefix string
---@return nil
function M.setup_modules(mod_prefix)
  M.iter_modules(mod_prefix):each(M.call_setup)
end

return M
