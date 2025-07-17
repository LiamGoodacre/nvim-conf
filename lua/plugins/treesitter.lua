-- Add to the ensure_installed list and restart.
-- Check installed with :TSInstallInfo
return {
  "nvim-treesitter/nvim-treesitter",

  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,

  opts = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup(require("LiamGoodacre.language").treesitter_config)
  end
}
