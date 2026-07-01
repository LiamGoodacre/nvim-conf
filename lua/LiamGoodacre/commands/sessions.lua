local M = {}

local util = require("LiamGoodacre.util")


local sessions_dir =
  vim.fn.fnameescape(vim.fn.stdpath("config") .. "/.sessions/")


M._session_file = function(fname)
  return sessions_dir .. vim.fn.fnameescape(fname)
end


M._iter_sessions = function()
  return util.iter_dir(sessions_dir)
    :map(function(basename, filetype)
      if filetype == "file" then return basename end
    end)
end


M.record_session = function()
  vim.ui.input({
    prompt = "Record session: ",
  }, function(fname)
    if fname == nil then return end
    local result = pcall(vim.cmd.mksession, {
      bang = true,
      args = { M._session_file(fname) },
    })
    if not result then
      vim.notify("Failed to record session: " .. fname, vim.log.levels.ERROR)
    else
      vim.notify("Recorded session: " .. fname)
    end
  end)
end


M.switch_session = function()
  vim.ui.select(M._iter_sessions():totable(), {
    prompt = "Switch session:",
    format_item = function(item)
      return ("%s (%s)"):format(item, M._session_file(item))
    end,
  }, function(choice)
      if choice == nil then return end
      local result = pcall(vim.cmd.source, {
        args = { M._session_file(choice) },
      })
      if not result then
        vim.notify("Failed to load session: " .. choice, vim.log.levels.ERROR)
      else
        vim.notify("Loaded session: " .. choice)
      end
  end)
end


M.delete_session = function()
  vim.ui.select(M._iter_sessions():totable(), {
    prompt = "Delete session:",
  }, function(choice)
    if choice == nil then return end
    local result = pcall(vim.fs.rm, M._session_file(choice))
    if not result then
      vim.notify("Failed to delete session: " .. choice, vim.log.levels.ERROR)
    else
      vim.notify("Deleted session: " .. choice)
    end
  end)
end


M.setup = function()

  vim.api.nvim_create_user_command(
    "RecordSession",
    M.record_session,
    { desc = "Record session" })

  vim.api.nvim_create_user_command(
    "SwitchSession",
    M.switch_session,
    { desc = "Switch session" })

  vim.api.nvim_create_user_command(
    "DeleteSession",
    M.delete_session,
    { desc = "Delete session" })

end

return M
