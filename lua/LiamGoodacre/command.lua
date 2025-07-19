local M = {}

M.setup = function()

  require("LiamGoodacre.util").setup_modules("LiamGoodacre.commands")

  require("live-command").setup({
    commands =
      require("LiamGoodacre.util").fold_merge_modules(
        "LiamGoodacre.commands",
        function(command_module)
          return require(command_module).live_commands
        end,
        {
          G = { cmd = "g" },
          V = { cmd = "v" },
          Norm = { cmd = "norm" },
        }
      )
  })

end

return M
