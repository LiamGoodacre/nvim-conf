local M = {}

--- Register local commands and live-command previews.
M.setup = function()

  local util = require("LiamGoodacre.util")

  util.setup_modules("LiamGoodacre.command...")

  local get_live_commands = function(command_module)
    return command_module.live_commands or {}
  end

  require("live-command").setup({
    commands =
      util.iter_modules("LiamGoodacre.command...")
        :map(get_live_commands)
        :fold({
          G = { cmd = "g" },
          V = { cmd = "v" },
          Norm = { cmd = "norm" },
        }, util.table_merge_rtl)
  })

end

return M
