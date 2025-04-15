---@type vim.lsp.Config
return {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { "python" },
  root_markers = { "pyproject.toml" },
  capabilities = require("blink-cmp").get_lsp_capabilities(),
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "OrganizeImports", function()
      local params = {
        command = 'pyright.organizeimports',
        arguments = { vim.uri_from_bufnr(bufnr) },
      }

      client.request('workspace/executeCommand', params, nil, 0)
    end, { desc = "Organize imports using pyright" })
  end,
  offset_encoding = "utf-8",
}
