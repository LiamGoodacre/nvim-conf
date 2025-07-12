return {
  setup = function()
    require("LiamGoodacre.util").lsmod(
      "LiamGoodacre.commands",
      function(command_module) require(command_module).setup() end
    )
  end,
}
