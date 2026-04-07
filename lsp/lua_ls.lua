---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", { ".git" } },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      completion = {
        autoRequire = false,
        callSnippet = "Replace",
      },
    },
  },
}
