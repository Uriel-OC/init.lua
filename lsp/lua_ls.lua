---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { "init.lua" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}
