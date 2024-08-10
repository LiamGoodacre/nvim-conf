return {
  -- see ../plugins/treesitter.lua
  config = {
    sync_install = true,
    highlight = { enable = true },
    indent = { enable = false },
    incremental_selection = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "css",
      "diff",
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
  },
}
