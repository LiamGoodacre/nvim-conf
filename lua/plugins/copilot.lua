return {
  "github/copilot.vim",
  config = function()
    -- Disable copilot auto-suggestions.
    -- We'll explicitly request a suggestion via mappings.
    -- See ``LiamGoodacre/mappings/copilot.lua``.
    vim.g.copilot_enabled = false
    vim.g.copilot_no_maps = true
  end,
}
