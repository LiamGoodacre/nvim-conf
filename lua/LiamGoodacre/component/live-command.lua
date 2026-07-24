local M = {}

M.plugins = {
  { src = "https://github.com/smjonas/live-command.nvim" },
}


--- Register local commands and live-command previews.
M.after_load = function()

  local util = require("LiamGoodacre.util")

  local get_live_commands = function(component_module)
    return component_module.live_commands or {}
  end

  require("live-command").setup({
    commands =
      util.iter_modules("LiamGoodacre.component...")
        :map(get_live_commands)
        :fold({
          G = { cmd = "g" },
          V = { cmd = "v" },
          Norm = { cmd = "norm" },
        }, util.table_merge_rtl)
  })

end

return M
