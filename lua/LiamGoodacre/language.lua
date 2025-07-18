local M = {}

-- Discovers all required LSPs from LiamGoodacre.languages modules.
-- See ../plugins/mason-lsp.lua
M.mason_lspconfig = function()
  local lspconfig = {}

  lspconfig.ensure_installed = require("LiamGoodacre.util").fold_modules(
    "LiamGoodacre.languages",
    function(language_module) return require(language_module).lsps end,
    {}
  )

  return lspconfig
end

-- Discovers all required tools from LiamGoodacre.languages modules.
-- See ../plugins/mason-lsp.lua
M.mason_tool_installer = function()
  local tools = {}

  tools.ensure_installed = require("LiamGoodacre.util").fold_modules(
    "LiamGoodacre.languages",
    function(language_module) return require(language_module).tools end,
    { "tree-sitter-cli" }
  )

  return tools
end

-- see ../plugins/treesitter.lua
M.treesitter_config = {
  sync_install = true,
  highlight = { enable = true },
  indent = { enable = false },
  incremental_selection = { enable = true },
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "css",
    "diff",
    "dhall",
    "dot",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "haskell",
    "html",
    "javascript",
    "jq",
    "json",
    "lua",
    "make",
    "markdown",
    "mermaid",
    "nix",
    "passwd",
    "purescript",
    "python",
    "query",
    "regex",
    "rst",
    "scss",
    "sql",
    "terraform",
    "tmux",
    "toml",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
  },
}

-- Setup all LiamGoodacre.languages modules
M.setup = function()
  require("LiamGoodacre.util").setup_modules("LiamGoodacre.languages")
end

return M
