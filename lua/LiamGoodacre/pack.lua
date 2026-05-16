local M = {}

--- Copied from normalize_spec in vim.pack
local function nominalise(spec)
  local name = spec.name or spec.src:gsub("%.git$", "")
  spec.name = (type(name) == "string" and name or ""):match("[^/]+$") or ""
  return spec
end


---@type vim.pack.Spec[]
M.specs =
  vim.iter({
    { src = "https://github.com/alexghergh/nvim-tmux-navigation" },
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/github/copilot.vim" },
    { src = "https://github.com/goolord/alpha-nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/neovim-treesitter/nvim-treesitter" },
    { src = "https://github.com/neovim-treesitter/treesitter-parser-registry" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-symbols.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim", version = vim.version.range("*"), },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/smjonas/live-command.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  })
  :map(nominalise)
  :totable()


--- Install declared packages and add them to the runtime.
function M.setup()

  vim.cmd.packadd("nvim.undotree")

  -- We do this in 2 steps which makes it more lenient around
  -- plugin interdepedencies & load order.

  -- step 1: tell pack what plugins exist
  vim.pack.add(M.specs, { load = false, confirm = false })

  -- step 2: actually load the plugins
  vim.pack.add(M.specs, { load = true, confirm = false })

end

return M
