return {
  lsps = {"gopls"},
  setup = function()
    local exe =
      vim.iter({ "gopls" })
        :map(vim.fn.exepath)
        :find(function(e) return e ~= "" end)

    if not exe then return end

    vim.lsp.config("gopls", {
      -- Run gopls with Go modules disabled.
      cmd = { "env", "GO111MODULE=off", exe, "-remote=auto" },

      settings = {
        gopls = {
          analyses = {
            -- These are the only analyzers that are disabled by default in
            -- gopls.
            nilness = true,
            shadow = true,
            unusedparams = true,
            unusedwrite = true,
          },
          buildFlags = { "-tags=integration" }, -- for LSP support in integration tests
          staticcheck = true,
          expandWorkspaceToModule = false,
        },
      },

      -- Treat anything containing these files as a root directory. This
      -- prevents us ascending too far toward the root of the repository, which
      -- stops us from trying to ingest too much code.
      root_dir = function(buffnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(buffnr)
        local root_markers = {"README.md", "main.go", "go.mod", "LICENSE", ".git"}
        local matches = vim.fs.find(root_markers, {
          path = fname,
          upward = true,
          limit = 1,
        })

        -- If there are no matches, fall back to finding the Git ancestor.
        if #matches == 0 then
          return on_dir(vim.system(
            { "git", "rev-parse", "--show-toplevel" },
            { cwd = fname }
          ):wait().stdout)
        end

        return on_dir(vim.fn.fnamemodify(matches[1], ':p:h'))
      end,

      -- Collect less information about packages without open files.
      memoryMode = "DegradeClosed",

      flags = {
        -- gopls is a particularly slow language server, especially in wearedev.
        -- Debounce text changes so that we don't send loads of updates.
        debounce_text_changes = 500,
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
