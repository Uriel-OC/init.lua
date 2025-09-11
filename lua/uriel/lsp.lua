local ms = vim.lsp.protocol.Methods

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("AttachStuff", { clear = true }),
  callback = function(event)
    -- Unset 'omnifunc'
    vim.bo[event.buf].omnifunc = nil

    -- Get LSP client
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client == nil then
      return false
    end

    local fzf = require "fzf-lua"
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map("gd", fzf.lsp_definitions, "[G]oto [D]efinition")

    -- Jump to the type of the word under your cursor.
    --  Useful when you"re not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map("<leader>D", fzf.lsp_typedefs, "Type [D]efinition")

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map("<leader>ws", fzf.lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client:supports_method(ms.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup("LspHighlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("DetachStuff", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "LspHighlight", buffer = event2.buf }
        end,
      })
    end

    if client:supports_method(ms.textDocument_inlayHint, event.buf) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, "[T]oggle Inlay [H]ints")
    end

    if client:supports_method(ms.textDocument_rangeFormatting, event.buf) then
      vim.api.nvim_clear_autocmds { group = "ByeWhite", buffer = event.buf }
    end
  end,
})

vim.diagnostic.config {
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_lines = {
    severity = vim.diagnostic.severity.ERROR,
    current_line = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  float = { source = "if_many" },
  severity_sort = true,
}

vim.lsp.enable {
  -- Lua
  "lua_ls",
  -- LaTeX
  "texlab",
  -- Typst
  "tinymist",
  -- Python
  "pyright", "ruff",
  -- Julia
  "julials",
  -- C/C++/CUDA
  "clangd",
  -- Terraform
  "terraformls",
}
