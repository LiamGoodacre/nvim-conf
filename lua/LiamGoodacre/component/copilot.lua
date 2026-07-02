local M = {}

M.before_load = function()
  vim.g.copilot_enabled = false
  vim.g.copilot_no_tab_map = true
  vim.g.copilot_no_maps = true
end


M.plugins = {
  { src = "https://github.com/github/copilot.vim" },
}


M.after_load = function()

  vim.keymap.set("i", "<M-Bslash>", vim.fn["copilot#Suggest"], { silent = true })

  vim.keymap.set("i", "<M-]>", vim.fn["copilot#Next"], { silent = true })

  vim.keymap.set("i", "<M-[>", vim.fn["copilot#Previous"], { silent = true })

  vim.keymap.set("i", "<M-w>", function()
    vim.schedule(vim.fn["copilot#Suggest"])
    vim.api.nvim_feedkeys(vim.fn["copilot#AcceptWord"](), "in", false)
  end, { silent = true })

  vim.keymap.set("i", "<M-l>", function()
    vim.schedule(vim.fn["copilot#Suggest"])
    vim.api.nvim_feedkeys(vim.fn["copilot#AcceptLine"](""), "in", false)
  end, { silent = true })

  vim.keymap.set("i", "<M-y>", function()
    vim.api.nvim_feedkeys(vim.fn["copilot#Accept"](""), "in", false)
  end, { silent = true })

  vim.keymap.set("i", "<M-n>", vim.fn["copilot#Dismiss"], { silent = true })

end

return M
