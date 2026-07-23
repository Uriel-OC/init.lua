local ms = vim.lsp.protocol.Methods

local highlight_augroup = vim.api.nvim_create_augroup("LspHighlight", { clear = false })
local attach_augroup = vim.api.nvim_create_augroup("AttachStuff", { clear = true })
local detach_augroup = vim.api.nvim_create_augroup("DetachStuff", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = attach_augroup,
  callback = function(event)
    -- Unset 'omnifunc'
    vim.bo[event.buf].omnifunc = nil

    -- Get LSP client
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client == nil then return end

    local function map(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client:supports_method(ms.textDocument_documentHighlight, event.buf) then
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
        group = detach_augroup,
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "LspHighlight", buffer = event2.buf }
        end,
      })
    end

    if client:supports_method(ms.textDocument_codeLens, event.buf) then
      vim.lsp.codelens.enable(true, { bufnr = event.buf })
    end

    if client:supports_method(ms.textDocument_inlineCompletion, event.buf) then
      vim.lsp.inline_completion.enable(true, { bufnr = event.buf })

      vim.keymap.set('i', '<Tab>', function()
        if not vim.lsp.inline_completion.get() then
          return '<Tab>'
        end
      end, { expr = true, desc = 'Accept the current inline completion', buf = event.buf })
    end

    if client:supports_method(ms.textDocument_inlayHint, event.buf) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, "[T]oggle Inlay [H]ints")
    end

    if client:supports_method(ms.textDocument_rangeFormatting, event.buf) then
      vim.api.nvim_clear_autocmds { group = "ByeWhite", buffer = event.buf }
    end

    if client:supports_method(ms.textDocument_foldingRange, event.buf) then
      local winid = vim.api.nvim_get_current_win()
      vim.wo[winid][0].foldmethod = "expr"
      vim.wo[winid][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})

vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local value = ev.data.params.value
    vim.api.nvim_echo({ { value.message or "done" } }, false, {
      id = "lsp." .. ev.data.params.token,
      kind = "progress",
      source = "vim.lsp",
      title = value.title,
      status = value.kind ~= "end" and "running" or "success",
      percent = value.percentage,
    })
  end,
})

vim.diagnostic.config {
  underline = { severity = vim.diagnostic.severity.WARN },
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

local servers = vim.tbl_map(
  function(file) return vim.fn.fnamemodify(file, ':t:r') end,
  vim.api.nvim_get_runtime_file("lsp/*.lua", true)
)

vim.lsp.enable(servers)

vim.pack.add {
  "https://github.com/folke/lazydev.nvim"
}

require("lazydev.config").setup {
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "mini.icons",         words = { "MiniIcons" } },
    { path = "mini.statusline",    words = { "MiniStatusline" } },
    { path = "mini.git",           words = { "MiniGit" } },
    { path = "mini.diff",          words = { "MiniDiff" } },
    { path = "snip_env",           files = { "snippets/*.lua" } },
  },
  integrations = {
    lspconfig = false,
    cmp = false,
  },
}
