return {
  lsps = {"starpls"},
  setup = function()
    vim.lsp.config("starpls", {
      filetypes = { "bzl", "bazel", "bazelrc", "WORKSPACE" },
      root_dir = require("lspconfig.util").root_pattern("WORKSPACE", "WORKSPACE.bazel", ".git"),
    })
  end,
}
