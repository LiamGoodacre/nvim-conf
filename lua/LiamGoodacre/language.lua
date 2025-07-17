local M = {}

-- Discovers all required LSPs from LiamGoodacre.languages modules.
-- See ../plugins/mason-lsp.lua
M.mason_lspconfig = function()
  local ensure_installed = {}

  require("LiamGoodacre.util").lsmod(
    "LiamGoodacre.languages",
    function(language_module)
      for _, lsp in ipairs(require(language_module).lsps or {}) do
        table.insert(ensure_installed, lsp)
      end
    end
  )

  return {
    ensure_installed = ensure_installed,
  }
end

-- Discovers all required tools from LiamGoodacre.languages modules.
-- See ../plugins/mason-lsp.lua
M.mason_tool_installer = function()
  local ensure_installed = {
    "tree-sitter-cli",
  }

  require("LiamGoodacre.util").lsmod(
    "LiamGoodacre.languages",
    function(language_module)
      for _, tool in ipairs(require(language_module).tools or {}) do
        table.insert(ensure_installed, tool)
      end
    end
  )

  return {
    ensure_installed = ensure_installed,
  }
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
  require("LiamGoodacre.util").lsmod(
    "LiamGoodacre.languages",
    function(language_module) require(language_module).setup() end
  )
end

return M
