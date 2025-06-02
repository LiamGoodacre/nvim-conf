return {
  lsps = {"hls"},
  setup = function()
    local haskell = "LiamGoodacre-haskell"
    vim.filetype.add({ extension = { hs = haskell, lhs = haskell } })
    vim.treesitter.language.register("haskell", haskell)
    require("lspconfig").hls.setup({ filetypes = { haskell, "cabal" } })

    -- on save, format the file with hls
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      pattern = { haskell },
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { haskell, "cabal" },
      callback = function()
        -- @ = alphanumeric characters,
        -- 39 = single quote
        -- 48-57 = digits
        -- _ = underscore
        -- 192-255 = extended ASCII
        vim.opt_local.iskeyword = "@,39,48-57,_,192-255"
      end,
    })
  end,
}
