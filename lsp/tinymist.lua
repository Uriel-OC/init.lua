---@type vim.lsp.Config
return {
  cmd = { "tinymist", "lsp" },
  filetypes = { "typst" },
  root_markers = { "main.typ" },
  settings = {
    formatterPrintWidth = 80,
    completion = {
      triggerOnSnippetPlaceholders = true,
    },
    lint = {
      enabled = true,
    },
    projectResolution = "lockDatabase",
  },
}
