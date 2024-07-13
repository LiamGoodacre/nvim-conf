vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

-- pane navigation
vim.keymap.set("n", "<Up>", "<C-w>k")
vim.keymap.set("n", "<Right>", "<C-w>l")
vim.keymap.set("n", "<Down>", "<C-w>j")
vim.keymap.set("n", "<Left>", "<C-w>h")

-- tab control
vim.keymap.set("n", "<leader>tn", ":tabn<CR>")
vim.keymap.set("n", "<leader>tp", ":tabp<CR>")
vim.keymap.set("n", "<leader>tN", ":tabm +1<CR>")
vim.keymap.set("n", "<leader>tP", ":tabm -1<CR>")

-- explore
vim.keymap.set("n", "<leader>x", vim.cmd.Ex)
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")

-- finding things
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>gg", telescope.git_files, {})
vim.keymap.set("n", "<C-space>", telescope.buffers, {})
vim.keymap.set("n", "<leader>bb", telescope.buffers, {})
vim.keymap.set("n", "<leader>rg", telescope.live_grep, {})
vim.keymap.set("n", "<leader>cs", telescope.colorscheme, {})
vim.keymap.set("n", "<leader>\"p", telescope.registers, {})
vim.keymap.set("n", "<leader>hk", telescope.keymaps, {})
vim.keymap.set("n", "<leader><C-o>", telescope.keymaps, {})
vim.keymap.set("n", "gr", telescope.lsp_references, {})
vim.keymap.set("n", "<leader>br", telescope.git_branches, {})
vim.keymap.set("n", "<leader>ts", telescope.treesitter, {})
vim.keymap.set("n", "<leader>tt", telescope.builtin, {})
