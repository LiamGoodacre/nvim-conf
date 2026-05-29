local M = {}

M.setup = function()

  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
  vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client or not client:supports_method("textDocument/completion") then
        return
      end

      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = false,
      })

      vim.keymap.set("i", "<C-Space>", function()
        vim.lsp.completion.get()
      end, { buffer = args.buf })
    end,
  })

end

return M
