-- Vim plugins --
-- dispatch
vim.g.dispatch_no_maps = 1
-- matchup
vim.g.matchup_treesitter_stopline = 500
vim.g.matchup_matchparen_deferred = 1
vim.g.matchup_matchparen_offscreen = {}

vim.pack.add({
  "https://github.com/tpope/vim-dispatch",
  "https://github.com/andymass/vim-matchup",
})

-- dispatch
vim.keymap.set("n", "mm", "<Cmd>Make!<CR>", { silent = true, desc = "Asynchronous build" })
vim.keymap.set("n", "m<Space>", ":Make! ", { desc = "Pass arguments to :Make!" })

-- Better pane jumping --
vim.pack.add({
  "https://github.com/mrjones2014/smart-splits.nvim",
})

local splits = require "smart-splits"

splits.setup {
  default_amount = 2,
}

vim.keymap.set({ "n", "i" }, "<M-h>", splits.move_cursor_left)
vim.keymap.set({ "n", "i" }, "<M-j>", splits.move_cursor_down)
vim.keymap.set({ "n", "i" }, "<M-k>", splits.move_cursor_up)
vim.keymap.set({ "n", "i" }, "<M-l>", splits.move_cursor_right)
vim.keymap.set("n", "<C-S-Left>", splits.resize_left)
vim.keymap.set("n", "<C-S-Down>", splits.resize_down)
vim.keymap.set("n", "<C-S-Up>", splits.resize_up)
vim.keymap.set("n", "<C-S-Right>", splits.resize_right)

-- Sometime-needed plugins --
vim.api.nvim_create_user_command("SlimeSetUp", function()
  vim.g.slime_target = "kitty"
  vim.g.slime_no_mappings = 1
  vim.g.slime_bracketed_paste = 1

  vim.pack.add({ "https://github.com/jpalardy/vim-slime" })

  vim.keymap.set("n", "gzz", "<Plug>SlimeLineSend", { desc = "Send {count} line(s) to REPL" })
  vim.keymap.set("n", "gz", "<Plug>SlimeMotionSend", { desc = "Send {motion} text to REPL" })
  vim.keymap.set("x", "gz", "<Plug>SlimeRegionSend", { desc = "Send {visual} text to REPL" })
end, { desc = "Command that enables 'vim-slime' plugin and defines its keymaps", nargs = 0 })
