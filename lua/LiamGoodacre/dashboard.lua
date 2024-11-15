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
      alpha_dashboard.button("n",       "  Σ :New", "<Cmd>ene<CR>"),
      alpha_dashboard.button("c c",     "  Σ :Config", "<Cmd>Config<CR>"),
      alpha_dashboard.button("c x",     "  Σ :ConfigTmux", "<Cmd>ConfigTmux<CR>"),
      alpha_dashboard.button("c t",     "  Σ :ConfigTerm", "<Cmd>ConfigTerm<CR>"),
      alpha_dashboard.button("SPC b b", "  Σ :Browse"),
      alpha_dashboard.button("SPC f f", "  Σ :Files"),
      alpha_dashboard.button("SPC g g", "  Σ :GitFiles"),
      alpha_dashboard.button("SPC r g", "  Σ :Telescope live_grep"),
      alpha_dashboard.button("SPC h k", "  Σ :HelpKeys"),
    }

  end,
}
