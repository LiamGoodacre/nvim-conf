-- Add to the ensure_installed list and restart.
-- Check installed with :TSInstallInfo
return {
  "nvim-treesitter/nvim-treesitter",

  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,

  opts = function()

    require("nvim-treesitter.configs").setup({
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
    })

  end
}
