return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- transparent = true,
    styles = {
      -- sidebars = "transparent",
      -- floats = "transparent",
    },
    on_highlights = function(hl, c)
      hl.CopilotSuggestion = {
        bg = hl.Keyword.fg,
        fg = "#000000",
      }
    end,
  },
}
