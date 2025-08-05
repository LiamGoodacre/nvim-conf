local haskell = "LiamGoodacre-haskell"
local hspattern = { haskell, "*.hs", "*.lhs" }
local pattern = { haskell, "*.hs", "*.lhs", "*.cabal" }

local use_hls = true

local format_with = "ormolu" -- can be "ormolu", "bormolu-format", or "lsp"
local format_on = "BufWritePre"

local using_git_root = function(k)
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if not git_root or git_root == "" then
    return
  end

  k(git_root)
end

local update_tags = function()
  if vim.g.block_tags then
    return
  end

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

local bormolu_format = function()
  using_git_root(function(git_root)
    vim.fn.jobstart({ "bormolu-format", "--", vim.fn.expand("%:p") }, {
      cwd = git_root,
      stdout_buffered = true,
      on_exit = function(_, code)
        if code ~= 0 then
          vim.notify("bormolu-format failed with code: " .. code, vim.log.levels.ERROR)
          return
        end

        vim.cmd("silent! checktime")
        vim.notify("formatted with bormolu-format", vim.log.levels.INFO)
      end,
    })
  end)
end

local format = function()
  -- check the global flag to see if formatting is enabled
  if vim.g.block_formatting then
    return
  end

  if format_with == "ormolu" then
    ormolu_on_buffer()
  elseif format_with == "bormolu-format" then
    bormolu_format()
  elseif format_with == "lsp" then
    vim.lsp.buf.format({ async = true })
  else
    vim.notify("Unknown format method: " .. format_with, vim.log.levels.ERROR)
  end
end

return {
  lsps = ({[true] = {"hls"}, [false] = {}})[use_hls],
  update_tags = update_tags,
  format = format,
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

    vim.api.nvim_create_autocmd(format_on, {
      pattern = hspattern,
      callback = format,
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = hspattern,
      callback = update_tags,
    })

  end,
}
