vim.opt.autoindent = false
vim.opt.confirm = true
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.directory = ".swaps"
vim.opt.expandtab = true
vim.opt.foldmethod=marker
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("I")
vim.opt.showmatch = false -- highlight matched brackets
vim.opt.signcolumn = "number" -- line number getter size
vim.opt.softtabstop = 2
vim.opt.spelllang = "en_gb"
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.wildmode:append("list")
vim.opt.wildmode:append("longest")
vim.opt.wrap = false

vim.cmd[[colorscheme tokyonight-night]]
