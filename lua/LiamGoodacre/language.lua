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

M.setup = function()

  local treesitter_registers = require("LiamGoodacre.util").fold_modules(
    "LiamGoodacre.languages",
    function(language_module)
      return language_module.treesitter_registers
    end
  )

  vim.iter(treesitter_registers):each(function(register)
    vim.treesitter.language.register(register.parser, register.filetype)
  end)

  require("LiamGoodacre.util").setup_modules("LiamGoodacre.languages")

  require("nvim-treesitter").install(treesitter_parsers)

  local treesitter_filetypes = vim.list_extend(
    vim.iter(treesitter_registers):map(function(register)
      return register.filetype
    end):totable(),
    vim.deepcopy(treesitter_parsers)
  )

  vim.api.nvim_create_autocmd("FileType", {
    pattern = treesitter_filetypes,
    callback = function()
      vim.treesitter.start()
    end,
  })

end

return M
