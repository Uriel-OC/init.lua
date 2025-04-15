---@type vim.lsp.Config
return {
  cmd = { "tinymist", "lsp" },
  filetypes = { "typst" },
  root_markers = { "main.typ" },
  capabilities = require("blink-cmp").get_lsp_capabilities(),
  settings = {
    exportPdf = "onSave",
    formatterMode = "typstyle",
    formatterPrintWidth = 80,
    completion = {
      triggerOnSnippetPlaceholders = true,
    },
  },
}
