return {
  lsps = {},
  setup = function()
    -- Markdown overrides expandtab tabstop=4 softtabstop=4 shiftwidth=4; I don't like that.
    -- https://github.com/neovim/neovim/blob/f1748b78e3165a0821a11f5ae1fb9398aa67c535/runtime/ftplugin/markdown.vim#L26-L28
    -- (technically not used now because I'm replacing markdown with LiamGoodacre-markdown)
    vim.g.markdown_recommended_style = 0

    local markdown = 'LiamGoodacre-markdown'
    vim.filetype.add({ extension = { md = markdown, markdown = markdown } })
    vim.treesitter.language.register('markdown', markdown)
  end,
}
