local M = {}

M.setup = function()

  vim.api.nvim_create_user_command("Config", function()
    vim.cmd.cd(vim.fn.stdpath("config") .. "/lua")
    vim.cmd("e LiamGoodacre/init.lua")
    vim.cmd.NvimTreeFindFile()
  end, { desc = "Open nvim config", })

  vim.api.nvim_create_user_command("ConfigTmux", function()
    vim.cmd.cd(vim.fn.stdpath("config") .. "/../tmux-conf")
    vim.cmd("e .tmux.conf")
  end, { desc = "Open tmux config", })

  vim.api.nvim_create_user_command("ConfigTerm", function()
    vim.cmd.cd(vim.fn.stdpath("config") .. "/../ghostty")
    vim.cmd("e config")
  end, { desc = "Open terminal config", })

  vim.api.nvim_create_user_command("ConfigScripts", function()
    vim.cmd.cd(vim.fn.stdpath("config") .. "/../provision-conf")
    vim.cmd("e scripts")
  end, { desc = "Open scripts", })

end

return M
