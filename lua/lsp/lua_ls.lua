-- lua/lsp/lua_ls.lua
return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

