local cancel_group = vim.api.nvim_create_augroup("CancelBuild", { clear = true })
local status_codes = {
  [0] = "Success",
  [1] = "Error",
  [2] = "Failure",
  [3] = "Cancelled",
}

---@type vim.lsp.Config
return {
  cmd = { "texlab" },
  filetypes = { "tex", "bib" },
  root_markers = { ".latexmkrc" },
  workspace_required = true,
  settings = {
    texlab = {
      build = {
        args = { "-silent" },
        useFileList = true,
        pdfDirectory = "output",
      },
      forwardSearch = {
        executable = "/Applications/sioyek.app/Contents/MacOS/sioyek",
        args = {
          "--reuse-window",
          "--execute-command",
          "turn_on_synctex",
          "--forward-search-file",
          "%f",
          "--forward-search-line",
          "%l",
          "%p",
        },
      },
      chktex = { onEdit = true },
      latexFormatter = "tex-fmt",
      hover = { symbols = "glyph" },
      experimental = { followPackageLinks = true },
    }
  },
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<localleader>ll", function()
      local win = vim.api.nvim_get_current_win()
      local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
      ---@diagnostic disable-next-line: param-type-mismatch
      client:request("textDocument/build", params, function(err, result)
        if err then
          error(tostring(err))
        end
        vim.notify("Build " .. status_codes[result.status], vim.log.levels.INFO)
      end)
    end, { silent = true, desc = "Compile PDF", buffer = bufnr })
    vim.keymap.set("n", "<localleader>lv", function()
      local win = vim.api.nvim_get_current_win()
      local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
      ---@diagnostic disable-next-line: param-type-mismatch
      client:request("textDocument/forwardSearch", params, function(err, result)
        if err then
          error(tostring(err))
        end
        vim.notify("Search " .. status_codes[result.status], vim.log.levels.INFO)
      end)
    end, { silent = true, desc = "Perform forward search", buffer = bufnr })

    vim.api.nvim_create_autocmd("VimLeavePre", {
      desc = "Cancel build gracefully before quit",
      group = cancel_group,
      buffer = bufnr,
      callback = function(args)
        client:exec_cmd({
          title = "Cancel build",
          command = "texlab.cancelBuild",
        }, { bufnr = args.buf }, function(err, _)
          if err then
            vim.notify("Failed to cancel build", vim.log.levels.ERROR)
          end
        end)
      end,
    })
  end
}
