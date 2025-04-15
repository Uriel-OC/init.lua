vim.opt_local.colorcolumn = "80"

vim.opt_local.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
