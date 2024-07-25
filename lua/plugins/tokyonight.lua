return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- transparent = true,
    styles = {
      sidebars = "dark",
      floats = "dark",
    },
    on_highlights = function(hl, c)
      hl.CopilotSuggestion = {
        bg = hl.Keyword.fg,
        fg = "#000000",
      }
    end,
  },
}
