---@type vim.lsp.Config
return {
  cmd = {
    "fortls",
    "--disable_autoupdate",
    "--hover_signature",
    "--hover_language=fortran",
    "--use_signature_help",
  },
  filetypes = { "fortran" },
  root_markers = { ".fortls", },
  workspace_required = true,
}
