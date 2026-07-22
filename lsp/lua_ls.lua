---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { "init.lua", { ".luarc.json" } },
  settings = {
    Lua = {
      codelens = { enable = true },
      completion = {
        autoRequire = false,
        callSnippet = "Replace",
      },
      hint = { enable = true },
      runtime = { version = "LuaJIT" },
    },
  },
}
