local M = {}

M.setup = function()
  local sessions = require("LiamGoodacre.commands.sessions")
  vim.keymap.set("n", "<leader>sw", sessions.record_session, { desc = "Record session" })
  vim.keymap.set("n", "<leader>se", sessions.switch_session, { desc = "Switch session" })
  vim.keymap.set("n", "<leader>sd", sessions.delete_session, { desc = "Delete session" })
end

return M
