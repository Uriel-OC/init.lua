---@type vim.lsp.Config
return {
  cmd = { "texlab" },
  filetypes = { "tex", "bibtex" },
  root_markers = { ".latexmkrc" },
  capabilities = require("blink-cmp").get_lsp_capabilities(),
  settings = {
    texlab = {
      build = {
        args = {
          "-lualatex",
          "-interaction=nonstopmode",
          "-synctex=1",
          "-shell-escape",
          "%f"
        },
        useFileList = true,
      },
      forwardSearch = {
        executable = "displayline",
        args = { "-r", "-b", "-n", "%l", "%p", "%f" },
      },
      chktex = { onEdit = true },
      latexFormatter = "tex-fmt",
      experimental = { followPackageLinks = true },
    }
  },
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<localleader>ll", function()
      local win = vim.api.nvim_get_current_win()
      local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
      client.request('textDocument/build', params, function(err, result)
        if err then
          error(tostring(err))
        end
        local texlab_build_status = {
          [0] = 'Success',
          [1] = 'Error',
          [2] = 'Failure',
          [3] = 'Cancelled',
        }
        vim.notify('Build ' .. texlab_build_status[result.status], vim.log.levels.INFO)
      end, bufnr)
    end, { silent = true, desc = "Compile PDF", buffer = bufnr })
    vim.keymap.set("n", "<localleader>lv", function()
      local win = vim.api.nvim_get_current_win()
      local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
      client.request('textDocument/forwardSearch', params, function(err, result)
        if err then
          error(tostring(err))
        end
        local texlab_forward_status = {
          [0] = 'Success',
          [1] = 'Error',
          [2] = 'Failure',
          [3] = 'Unconfigured',
        }
        vim.notify('Search ' .. texlab_forward_status[result.status], vim.log.levels.INFO)
      end, bufnr)
    end, { silent = true, desc = "Perform forward search", buffer = bufnr })
  end
}
