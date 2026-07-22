---@type vim.lsp.Config
return {
  cmd = { "jetls", "serve" },
  filetypes = { "julia" },
  root_markers = { "Manifest.toml" },
  init_options = {
    analysis_overrides = {
      { path = "src/**/*.jl" },
      { path = "test/**/*.jl" },
    }
  },
  workspace_required = true
}
