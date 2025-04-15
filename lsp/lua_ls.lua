---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { "init.lua" },
  capabilities = require("blink-cmp").get_lsp_capabilities(),
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
}
