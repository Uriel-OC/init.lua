vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<Space>", "<nop>")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader><leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

if not vim.g.using_tmux then
  -- Moving around
  vim.keymap.set({ 'n', "i" }, '<M-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set({ 'n', "i" }, '<M-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set({ 'n', "i" }, '<M-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set({ 'n', "i" }, '<M-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
  -- Resizing
  vim.keymap.set('n', '<C-Left>', function()
    vim.cmd { cmd = "resize", args = { "+2" }, mods = { vertical = true } }
  end, { desc = "Increase window width" })
  vim.keymap.set('n', '<C-Right>', function()
    vim.cmd { cmd = "resize", args = { "-2" }, mods = { vertical = true } }
  end, { desc = "Decrease window width" })
  vim.keymap.set('n', '<C-Down>', function()
    vim.cmd.resize("-2")
  end, { desc = "Increase window height" })
  vim.keymap.set('n', '<C-Up>', function()
    vim.cmd.resize("+2")
  end, { desc = "Decrease window height" })
end

vim.keymap.set("n", "<leader>ts", function()
  if not vim.o.spell then
    vim.ui.select({ "es_mx", "en_us" }, { prompt = "Lang: " }, function(choice)
      vim.opt_local.spelllang = choice
      vim.opt_local.spell = true
    end)
  else
    vim.opt_local.spelllang = ""
    vim.opt_local.spell = false
  end
end, { desc = "Toggle spell check", silent = true })
