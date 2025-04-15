---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml" },
  capabilities = require("blink-cmp").get_lsp_capabilities(),
  settings = {},
  offset_encoding = "utf-8",
}
