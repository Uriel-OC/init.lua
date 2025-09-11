---@type vim.lsp.Config
return {
  cmd = { "tinymist", "lsp" },
  filetypes = { "typst" },
  root_markers = { "main.typ" },
  settings = {
    exportPdf = "onSave",
    formatterMode = "typstyle",
    formatterPrintWidth = 80,
    completion = {
      triggerOnSnippetPlaceholders = true,
    },
  },
}
