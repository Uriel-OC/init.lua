local lazy = require("utils").lazy_augroup

---@param filetype string|string[]
---@param callback string|fun(args: vim.api.keyset.create_autocmd.callback_args):boolean?
local function ftautocmd(filetype, callback)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetype,
    once = true,
    group = lazy,
    callback = callback
  })
end

-- Typst
ftautocmd("typst", function()
  vim.pack.add({
    {
      src = "https://github.com/chomosuke/typst-preview.nvim",
      version = vim.version.range("1.*")
    }
  })

  require("typst-preview").setup {
    port = 4321,
    dependencies_bin = {
      tinymist = "tinymist",
      websocat = "websocat",
    }
  }
end)
