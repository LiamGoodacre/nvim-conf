return {
  lsps = {"starpls"},
  setup = function()
    vim.lsp.config("starpls", {
      filetypes = { "bzl", "bazel", "bazelrc" },
      root_markers = { "WORKSPACE", "WORKSPACE.bazel", ".git" },
    })
  end,
}
