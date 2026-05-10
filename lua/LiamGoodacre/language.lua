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

  local util = require("LiamGoodacre.util")

  local treesitter_registers =
    util.iter_submodules("LiamGoodacre.languages")
      :map(function(m) return m.treesitter_registers end)
      :flatten(1)
      :totable()

  vim.iter(treesitter_registers):each(function(register)
    vim.treesitter.language.register(register.parser, register.filetype)
  end)

  util.setup_submodules("LiamGoodacre.languages")

  require("nvim-treesitter").install(treesitter_parsers)

  local treesitter_filetypes = vim.list_extend(
    vim.iter(treesitter_registers)
      :map(function(r) return r.filetype end)
      :flatten(1)
      :totable(),
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
