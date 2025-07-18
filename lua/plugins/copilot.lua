return {
  "github/copilot.vim", tag = "v1.55.0", -- later than 1.56 requires node 22+
  config = function()
    -- Disable copilot auto-suggestions.
    -- We'll explicitly request a suggestion via mappings.
    -- See ``LiamGoodacre/mappings/copilot.lua``.
    vim.g.copilot_enabled = false
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_no_maps = true
  end,
}
