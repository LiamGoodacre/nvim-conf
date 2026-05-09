local M = {}

M.setup = function()

  local util = require("LiamGoodacre.util")

  util.setup_modules("LiamGoodacre.commands")

  require("live-command").setup({
    commands =
      util.iter_fold_merge(
        util.modules("LiamGoodacre.commands"):map(
          function(command_module)
            return command_module.live_commands or {}
          end
        ),
        {
          G = { cmd = "g" },
          V = { cmd = "v" },
          Norm = { cmd = "norm" },
        }
      )
  })

end

return M
