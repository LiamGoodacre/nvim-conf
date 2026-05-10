local M = {}

M.setup = function()

  local util = require("LiamGoodacre.util")

  util.setup_modules("LiamGoodacre.commands")

  local function get_live_commands(command_module)
    return command_module.live_commands or {}
  end

  require("live-command").setup({
    commands =
      util.iter_modules("LiamGoodacre.commands")
        :map(get_live_commands)
        :fold({
          G = { cmd = "g" },
          V = { cmd = "v" },
          Norm = { cmd = "norm" },
        }, util.table_merge_rtl)
  })

end

return M
