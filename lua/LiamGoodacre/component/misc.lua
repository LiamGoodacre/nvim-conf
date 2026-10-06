local M = {}

M.before_load = function()

  vim.cmd.packadd("nvim.undotree")

  -- Keep installed parsers and queries in sync with plugin upgrades.
  vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("LiamGoodacre-treesitter-update", { clear = true }),
    callback = function(event)
      if event.data.spec.name == "nvim-treesitter" and event.data.kind == "update" then
        if not event.data.active then
          vim.cmd.packadd("nvim-treesitter")
        end
        local treesitter = require("nvim-treesitter")
        treesitter.update(treesitter.get_available(), { summary = true })
      end
    end,
  })

end


M.plugins = {
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
}

return M
