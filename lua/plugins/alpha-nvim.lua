return {
  "goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.opts.hl = "Character"

    dashboard.section.header.val = {
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
      dashboard.button("n",       "  Σ New      ", "<Cmd>ene<CR>"),
      dashboard.button("SPC x x", "  Σ Browse   "),
      dashboard.button("SPC f f", "  Σ Files    "),
      dashboard.button("SPC g g", "  Σ Git files"),
      dashboard.button("SPC h k", "  Σ Help keys"),
    }

    alpha.setup(dashboard.opts)
  end,
}
