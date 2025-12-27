---@type vim.lsp.Config
return {
  cmd = { "texlab" },
  filetypes = { "tex", "bibtex" },
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
        executable = "displayline",
        args = { "-r", "-b", "-n", "%l", "%p", "%f" },
      },
      chktex = { onEdit = true },
      experimental = { followPackageLinks = true },
    }
  },
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<localleader>ll", function()
      local win = vim.api.nvim_get_current_win()
      local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
      ---@diagnostic disable-next-line: param-type-mismatch
      client.request("textDocument/build", params, function(err, result)
        if err then
          error(tostring(err))
        end
        local texlab_build_status = {
          [0] = "Success",
          [1] = "Error",
          [2] = "Failure",
          [3] = "Cancelled",
        }
        vim.notify("Build " .. texlab_build_status[result.status], vim.log.levels.INFO)
      end)
    end, { silent = true, desc = "Compile PDF", buffer = bufnr })
    vim.keymap.set("n", "<localleader>lv", function()
      local win = vim.api.nvim_get_current_win()
      local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
      ---@diagnostic disable-next-line: param-type-mismatch
      client.request("textDocument/forwardSearch", params, function(err, result)
        if err then
          error(tostring(err))
        end
        local texlab_forward_status = {
          [0] = "Success",
          [1] = "Error",
          [2] = "Failure",
          [3] = "Unconfigured",
        }
        vim.notify("Search " .. texlab_forward_status[result.status], vim.log.levels.INFO)
      end)
    end, { silent = true, desc = "Perform forward search", buffer = bufnr })

    vim.api.nvim_buf_create_user_command(bufnr, "LspTexlabClean", function()
      client:exec_cmd({
        title = "Clean auxiliary",
        command = "texlab.cleanAuxiliary",
        arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
      }, { bufnr = bufnr }, function(err, _)
        if err then
          vim.notify("Failed to clean auxiliary files", vim.log.levels.ERROR)
        end
      end)
      client:exec_cmd({
        title = "Clean artifacts",
        command = "texlab.cleanArtifacts",
        arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
      }, { bufnr = bufnr }, function(err, _)
        if err then
          vim.notify("Failed to clean artifacts", vim.log.levels.ERROR)
        end
      end)
    end, { desc = "Clean auxiliary files and artifacts" })

    vim.api.nvim_create_autocmd("QuitPre", {
      desc = "Cancel build gracefully before quit",
      group = vim.api.nvim_create_augroup("CancelBuild", { clear = true }),
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
