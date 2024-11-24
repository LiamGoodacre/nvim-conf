local theme = "tokyonight-night"

return {
  editor_theme = theme,
  status_theme = theme,
  setup = function()
    vim.cmd.colorscheme(theme)
  end,
  highlights = function(hl)
    hl.CopilotSuggestion = {
      bg = hl.Keyword.fg,
      fg = "#000000",
    }
  end,
}
