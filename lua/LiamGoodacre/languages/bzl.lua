return {
  lsps = {'bzl'},
  setup = function()
    require("lspconfig").bzl.setup({
      filetypes = { "bzl", "bazel", "bazelrc", "WORKSPACE" },
      root_dir = require("lspconfig.util").root_pattern("WORKSPACE", "WORKSPACE.bazel", ".git"),
    })
  end,
}
