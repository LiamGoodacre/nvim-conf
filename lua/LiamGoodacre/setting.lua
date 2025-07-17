local M = {}

-- Configures leader & basic vim.opt settings
M.setup = function()

  -- It's important these are set before lazy is setup.
  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"

  vim.opt.autoindent = true
  vim.opt.breakindent = true
  vim.opt.confirm = true
  vim.opt.cursorcolumn = true
  vim.opt.cursorline = true
  vim.opt.directory = vim.fn.stdpath("config") .. "/.swaps"
  vim.opt.expandtab = true
  vim.opt.foldmethod = "marker"
  vim.opt.hidden = true
  vim.opt.inccommand = "split"
  vim.opt.list = true
  vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
  vim.opt.mouse = "a"
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.shiftround = true
  vim.opt.shiftwidth = 2
  vim.opt.shortmess:append("I")
  vim.opt.showmatch = false -- highlight matched brackets
  vim.opt.showmode = false
  vim.opt.signcolumn = "number" -- line number getter size
  vim.opt.smartindent = false
  vim.opt.softtabstop = 2
  vim.opt.spelllang = "en_gb"
  vim.opt.tabstop = 2
  vim.opt.termguicolors = true
  vim.opt.wildmode:append("list")
  vim.opt.wildmode:append("longest")
  vim.opt.wrap = false

end

return M
