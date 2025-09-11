---@type vim.lsp.Config
return {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "cuda" },
  root_markers = { ".clangd", "compile_flags.txt" },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
  }
}
