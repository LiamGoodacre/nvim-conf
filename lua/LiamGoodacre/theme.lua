local theme = "tokyonight-night"

return {
  editor_theme = theme,
  status_theme = theme,
  setup = function()
    vim.cmd.colorscheme(theme)

    local lsp_open_floating_preview = vim.lsp.util.open_floating_preview
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.util.open_floating_preview = function(contents, format, config)
      return lsp_open_floating_preview(contents, format, vim.tbl_deep_extend("force", config or {}, {
        border = "rounded",
      }))
    end

  end,
  highlights = function(hl)
    hl.CopilotSuggestion = {
      bg = hl.Keyword.fg,
      fg = "#000000",
    }
  end,
}
