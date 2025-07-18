local M = {}

-- Apply theme & other visual settings
M.setup = function()

  require("tokyonight").setup({
    styles = {
      sidebars = "dark",
      floats = "dark",
    },
    cache = true,
    on_highlights = function(hl)
      hl.CopilotSuggestion = {
        bg = hl.Keyword.fg,
        fg = "#000000",
      }
    end,
  })

  vim.cmd.colorscheme("tokyonight-night")

  local lsp_open_floating_preview = vim.lsp.util.open_floating_preview
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.lsp.util.open_floating_preview = function(contents, format, config)
    return lsp_open_floating_preview(
      contents,
      format,
      vim.tbl_deep_extend("force", config or {}, { border = "rounded" }))
  end

  require('lualine').setup()

end

return M
