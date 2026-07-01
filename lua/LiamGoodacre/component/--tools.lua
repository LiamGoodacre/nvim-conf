local M = {}

M.plugins = {
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
}


M.after_load = function()

  require("mason").setup()

  local util = require("LiamGoodacre.util")

  require("mason-lspconfig").setup({
    ensure_installed =
      util.iter_modules("LiamGoodacre.language...")
        :map(function(m) return m.lsps end)
        :flatten(1)
        :totable(),
  })

  require("mason-tool-installer").setup({
    ensure_installed =
      vim.list_extend(
        { "tree-sitter-cli" },
        util.iter_modules("LiamGoodacre.language...")
          :map(function(m) return m.tools end)
          :flatten(1)
          :totable()
      ),
  })

end

return M
