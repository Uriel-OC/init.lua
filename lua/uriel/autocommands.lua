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
  callback = function()
    if vim.o.number then
      vim.opt_local.relativenumber = false
    end
  end
})
autocmd("InsertLeave", {
  desc = "Turn on 'relativenumber'",
  group = relative_num,
  callback = function()
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

-- Writing options
autocmd("FileType", {
  desc = "Set relevant options in writing filetypes",
  group = augroup("LetsWrite", { clear = true }),
  pattern = { "gitcommit", "markdown", "tex", "typst" },
  callback = function(event)
    local winid = vim.api.nvim_get_current_win()

    vim.wo[winid][0].colorcolumn = "80"

    vim.keymap.set("n", "<leader>ts", function()
      if not vim.o.spell then
        vim.ui.select({ "es_mx", "en_us" }, { prompt = "Lang: " }, function(choice)
          vim.bo.spelllang = choice
        end)
        vim.wo[winid][0].spell = true
      else
        vim.bo.spelllang = ""
        vim.wo[winid][0].spell = false
      end
    end, { desc = "Toggle spell check", buffer = event.buf })
  end
})
