return {
  setup = function()
    require("lazy.core.util").lsmod(
      "LiamGoodacre.commands",
      function(command_module) require(command_module).setup() end
    )
  end,
}
