local M = {}

local treesitter_changed = false
local plugins_loaded = false

local function update_treesitter()
  vim.cmd.TSUpdate()
end

M.specs = {
  { src = "https://github.com/alexghergh/nvim-tmux-navigation" },
  { src = "https://github.com/goolord/alpha-nvim" },
  { src = "https://github.com/github/copilot.vim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/neovim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim-treesitter/treesitter-parser-registry" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-symbols.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/smjonas/live-command.nvim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
}

M.load_order = {
  "plenary.nvim",
  "nvim-web-devicons",
  "treesitter-parser-registry",
  "nvim-lspconfig",
  "mason.nvim",
  "mason-lspconfig.nvim",
  "mason-tool-installer.nvim",
  "tokyonight.nvim",
  "lualine.nvim",
  "alpha-nvim",
  "live-command.nvim",
  "copilot.vim",
  "nvim-tmux-navigation",
  "nvim-tree.lua",
  "telescope-symbols.nvim",
  "telescope-ui-select.nvim",
  "telescope.nvim",
  "nvim-treesitter",
}

function M.add()
  vim.pack.add(M.specs, { load = false, confirm = false })
end

function M.load()
  for _, name in ipairs(M.load_order) do
    vim.cmd.packadd(name)
  end
  plugins_loaded = true
end

function M.setup_hooks()
  vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("LiamGoodacrePack", { clear = true }),
    callback = function(ev)
      if ev.data.spec.name == "nvim-treesitter"
          and (ev.data.kind == "install" or ev.data.kind == "update") then
        if plugins_loaded then
          vim.schedule(update_treesitter)
        else
          treesitter_changed = true
        end
      end
    end,
  })
end

function M.run_hooks()
  if treesitter_changed then
    update_treesitter()
    treesitter_changed = false
  end
end

return M
