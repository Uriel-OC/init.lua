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

vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader><leader>", vim.cmd.Undotree, { silent = true })
