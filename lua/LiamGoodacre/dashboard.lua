return {
  setup = function(alpha_dashboard)
    -- See ../plugins/alpha-nvim.lua

    alpha_dashboard.section.header.opts.hl = "Character"

    alpha_dashboard.section.header.val = {
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

    alpha_dashboard.section.buttons.val = {
      alpha_dashboard.button("n",       "  Σ New      ", "<Cmd>ene<CR>"),
      alpha_dashboard.button("SPC b b", "  Σ Browse   "),
      alpha_dashboard.button("SPC f f", "  Σ Files    "),
      alpha_dashboard.button("SPC g g", "  Σ Git files"),
      alpha_dashboard.button("SPC h k", "  Σ Help keys"),
    }

  end,
}
