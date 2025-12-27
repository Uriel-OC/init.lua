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
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspClangdShowSymbolInfo", function()
      local method_name = "textDocument/symbolInfo"
      if not client:supports_method(method_name) then
        return vim.notify("Clangd client not found", vim.log.levels.ERROR)
      end
      local win = vim.api.nvim_get_current_win()
      local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
      client:request(method_name, params, function(err, res)
        if err or #res == 0 then
          -- Clangd always returns an error, there is no reason to parse it
          return
        end
        local container = ("container: %s"):format(res[1].containerName)
        local name = ("name: %s"):format(res[1].name)
        vim.lsp.util.open_floating_preview({ name, container }, "", {
          height = 2,
          width = math.max(name:len(), container:len()),
          focusable = false,
          focus = false,
          title = "Symbol Info",
        })
      end, bufnr)
    end, { desc = "Show symbol info" })
  end
}
