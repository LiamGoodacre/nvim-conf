return {
  lsps = {"lua_ls"},
  setup = function()

    local lua = "LiamGoodacre-lua"
    vim.filetype.add({ extension = { lua = lua } })
    vim.treesitter.language.register("lua", lua)

    -- Copied from:
    -- https://github.com/neovim/nvim-lspconfig/blob/216deb2d1b5fbf24398919228208649bbf5cbadf/doc/server_configurations.md#lua_ls

    require("lspconfig").lua_ls.setup({
      filetypes = { lua },
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.uv.fs_stat(path.."/.luarc.json") or vim.uv.fs_stat(path.."/.luarc.jsonc") then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT"
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        })
      end,
      settings = {
        Lua = {}
      }
    })


  end,
}
