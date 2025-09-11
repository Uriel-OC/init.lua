---@type vim.lsp.Config
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml" },
  capabilities = {
    general = {
      positionEncodings = { "utf-16" },
    }
  }
}
