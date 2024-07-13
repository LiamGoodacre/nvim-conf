return {
  "goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.opts.hl = "Character"

    dashboard.section.header.val = {

      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⢀⣠⠶⠞⠛⠋⠉⠉⠉⠉⠙⠛⠳⠶⣄⡀⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⣠⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢷⣄⠀⠀⠀⠀",
      -- "⠀⠀⢀⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢷⡀⠀⠀",
      -- "⠀⢠⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⡄⠀",
      -- "⠀⣾⠁⠀⠀⠀⠀⠀⠀⠀⠀███⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣷⠀",
      -- "⢸⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹██⠀██⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡇",
      -- "⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸████⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇",
      -- "⢸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢹██⡏⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡇",
      -- "⠀⢿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸█⡏⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⠀",
      -- "⠀⠘⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠃⠀",
      -- "⠀⠀⠈⢷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠁⠀⠀",
      -- "⠀⠀⠀⠀⠙⢷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠋⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠈⠙⠶⢦⣤⣄⣀⣀⣀⣀⣠⣤⡴⠶⠋⠁⠀⠀⠀⠀⠀⠀",
      -- "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",

      -- "        ████████             ",
      -- "         ██████              ",
      -- "          ████  ██████       ",
      -- "          ████   ████        ",
      -- "           ████ ████         ",
      -- "           ████████          ",
      -- "            ██████           ",
      -- "            █████            ",
      -- "             ███             ",
      -- "             ██              ",

      "█████    █████",
      " ███      ███ ",
      "  ██      ██  ",
      "  ██████████  ",
      "   ██    ██   ",
      "   ███  ███   ",
      "    ██  ██    ",
      "    ██████    ",
      "     ████     ",
      "      ██      ",
      "     ⣀⣤⣤⣀     ",
      "     ⠈⠉⠉⠁     ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("n",         "  Σ New      ", "<Cmd>ene<CR>"),
      dashboard.button("Space e",   "  Σ Browse   ", "none"),
      dashboard.button("x",         "  Σ Explore  ", "<Cmd>Ex<CR>"),
      dashboard.button("Space f f", "  Σ Files    ", "none"),
      dashboard.button("Space g g", "  Σ Git files", "none"),
      dashboard.button("Space h k", "  Σ Help keys", "none"),
    }

    alpha.setup(dashboard.opts)
  end,
}
