local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlighting yank
autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Toggle relative number
local relative_num = augroup("ToggleRelNum", { clear = true })
autocmd("InsertEnter", {
  desc = "Turn off 'relativenumber'",
  group = relative_num,
  callback = function ()
    if vim.o.number then
      vim.opt_local.relativenumber = false
    end
  end
})
autocmd("InsertLeave", {
  desc = "Turn on 'relativenumber'",
  group = relative_num,
  callback = function ()
    if vim.o.number then
      vim.opt_local.relativenumber = true
    end
  end
})

-- Delete trailing whitespace
autocmd("BufWritePre", {
  desc = "Remove trailing whitespace before writing",
  group = augroup("ByeWhite", { clear = true }),
  command = [[keeppatterns %s/\s\+$//e]]
})
