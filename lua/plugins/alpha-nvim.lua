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
      dashboard.button("Space x x", "  Σ Browse   ", "<leader>xx"),
      dashboard.button("Space f f", "  Σ Files    ", "<leader>ff"),
      dashboard.button("Space g g", "  Σ Git files", "<leader>gg"),
      dashboard.button("Space h k", "  Σ Help keys", "<leader>hk"),
    }

    alpha.setup(dashboard.opts)
  end,
}
