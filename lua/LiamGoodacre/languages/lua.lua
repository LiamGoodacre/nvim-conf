return {
  lsps = {"lua_ls"},
  setup = function()
    -- Copied from:
    -- https://github.com/neovim/nvim-lspconfig/blob/216deb2d1b5fbf24398919228208649bbf5cbadf/doc/server_configurations.md#lua_ls

    vim.lsp.config("lua_ls", {
      filetypes = { "lua" },
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.uv.fs_stat(path.."/.luarc.json") or vim.uv.fs_stat(path.."/.luarc.jsonc") then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            path = {
              "lua/?.lua",
              "lua/?/init.lua",
            },
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = vim.list_extend(
              { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
              -- NOTE: this can be slow
              vim.api.nvim_get_runtime_file("lua", true)),
          },
          diagnostics = {
            disable = {
              "different-requires",
            },
          }
        })
      end,
      settings = {
        Lua = {}
      }
    })

  end,
}
