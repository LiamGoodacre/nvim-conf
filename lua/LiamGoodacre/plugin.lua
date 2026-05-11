local M = {}

local function before_load(s) return s.before_load end
local function after_load(s) return s.after_load end

--- Run plugin hooks around plugin installation and loading.
M.setup = function()

  local util = require("LiamGoodacre.util")

  util.iter_modules("LiamGoodacre.plugin_config...")
    :map(before_load)
    :each(util.call)

  require("LiamGoodacre.pack").setup()

  util.iter_modules("LiamGoodacre.plugin_config...")
    :map(after_load)
    :each(util.call)

end

return M
