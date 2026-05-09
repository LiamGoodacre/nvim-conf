local M = {}

local treesitter_parsers = {
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
  "rust",
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
  "zig",
}

local treesitter_filetypes = vim.list_extend({
  "LiamGoodacre-bash",
  "LiamGoodacre-csharp",
  "LiamGoodacre-haskell",
  "LiamGoodacre-lua",
  "LiamGoodacre-markdown",
  "LiamGoodacre-purescript",
  "LiamGoodacre-python",
  "LiamGoodacre-typescript",
  "LiamGoodacre-zig",
}, vim.deepcopy(treesitter_parsers))

M.setup = function()
  require("LiamGoodacre.util").setup_modules("LiamGoodacre.languages")

  require("nvim-treesitter").install(treesitter_parsers)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = treesitter_filetypes,
    callback = function()
      vim.treesitter.start()
    end,
  })
end

return M
