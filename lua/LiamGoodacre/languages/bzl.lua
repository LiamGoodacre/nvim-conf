return {
  lsps = {"bzl"},
  setup = function()
    vim.lsp.config("bzl", {
      filetypes = { "bzl", "bazel", "bazelrc", "WORKSPACE" },
      root_dir = require("lspconfig.util").root_pattern("WORKSPACE", "WORKSPACE.bazel", ".git"),
    })
  end,
}
