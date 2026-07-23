local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlighting yank
autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Toggle relative number
autocmd({ "InsertEnter", "InsertLeave" }, {
  desc = "Toogle 'relativenumber'",
  callback = function()
    local winid = vim.api.nvim_get_current_win()
    if vim.wo[winid].number then
      vim.wo[winid][0].relativenumber = not vim.wo[winid][0].relativenumber
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
      if not vim.wo[winid].spell then
        vim.ui.select({ "es_mx", "en_us" }, { prompt = "Lang: " }, function(choice)
          vim.bo[event.buf].spelllang = choice or ""
        end)
        vim.wo[winid].spell = true
      else
        vim.bo[event.buf].spelllang = ""
        vim.wo[winid].spell = false
      end
    end, { desc = "Toggle spell check", buffer = event.buf })
  end
})
