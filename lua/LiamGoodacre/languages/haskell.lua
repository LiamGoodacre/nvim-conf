local haskell = "LiamGoodacre-haskell"
local pattern = { haskell, "*.hs", "*.lhs", "*.cabal" }
local use_hls = true

local using_git_root = function(k)
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if not git_root or git_root == "" then
    return
  end

  k(git_root)
end

local update_tags = function()
  using_git_root(function(git_root)
    vim.fn.jobstart({ "hasktags-parallel" }, {
      cwd = git_root,
      stdout_buffered = true,
      on_exit = function(_, code)
        if code ~= 0 then
          vim.notify("hasktags-parallel failed with code: " .. code, vim.log.levels.ERROR)
          return
        end

        vim.notify("tags updated via hasktags-parallel", vim.log.levels.INFO)
      end,
    })
  end)
end

local ormolu_on_buffer = function()
  -- check the global flag to see if formatting is enabled
  if vim.g.block_formatting then
    return
  end

  local filename = vim.fn.expand("%:p")
  local filetype = vim.bo.filetype
  if filetype == haskell or filetype == "haskell" then
    -- track the cursor position so we can return to it after formatting
    local cursor = vim.api.nvim_win_get_cursor(0)
    -- As this is pre-write, we run ormolu directly on the buffer content.
    vim.cmd(":%! ormolu --stdin-input-file " .. filename)
    -- return the cursor to where it was before formatting,
    -- note that the position may no-longer be valid so we
    -- must check that the cursor is still within the buffer
    if vim.api.nvim_buf_is_valid(0) then
      local line_count = vim.api.nvim_buf_line_count(0)
      if cursor[1] <= line_count then
        vim.api.nvim_win_set_cursor(0, cursor)
      else
        -- if the cursor is out of bounds, move it to the last line
        vim.api.nvim_win_set_cursor(0, { line_count, 0 })
      end
    end
  end
end

return {
  lsps = ({[true] = {"hls"}, [false] = {}})[use_hls],
  update_tags = update_tags,
  setup = function()
    vim.filetype.add({ extension = { hs = haskell, lhs = haskell } })
    vim.treesitter.language.register("haskell", haskell)

    if use_hls then
      require("lspconfig").hls.setup({
        filetypes = { haskell, "haskell", "lhaskell", "cabal" },
        settings = {
          [haskell] = {
            formattingProvider = 'ormolu',
            cabalFormattingProvider = 'cabalfmt',
          },
        },
      })
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = pattern,
      callback = function()
        -- @ = alphanumeric characters,
        -- 39 = single quote
        -- 48-57 = digits
        -- _ = underscore
        -- 192-255 = extended ASCII
        vim.opt_local.iskeyword = "@,39,48-57,_,192-255"
      end,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = pattern,
      callback = function()
        -- this is currently not working, so we'll use ormolu directly
        -- vim.lsp.buf.format({ async = true })
        ormolu_on_buffer()
      end,
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = pattern,
      callback = function()
        update_tags()
      end,
    })

  end,
}
