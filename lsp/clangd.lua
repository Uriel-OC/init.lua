---@type vim.lsp.Config
return {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "cuda" },
  root_markers = { ".clangd", "compile_flags.txt" },
  capabilities = require("blink-cmp").get_lsp_capabilities {
    textDocument = {
        completion = {
          editsNearCursor = true,
        },
      },
  },
  settings = {},
  offset_encoding = "utf-16",
}
