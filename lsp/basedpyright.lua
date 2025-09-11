---@type vim.lsp.Config
return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml" },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
      client:exec_cmd({
        title = "Organize imports",
        command = "basedpyright.organizeimports",
        arguments = { vim.uri_from_bufnr(bufnr) },
      }, { bufnr = bufnr }, function(err, _)
        if err then
          vim.notify("Failed to organize imports", vim.log.levels.ERROR)
        end
      end
      )
    end, { desc = "Organize Imports" })
  end
}
