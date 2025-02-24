vim.opt_local.colorcolumn = "80"

vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.keymap.set("n", "<localleader>ll", vim.cmd.TexlabBuild, {silent=true, desc="Compile PDF"})
vim.keymap.set("n", "<localleader>lv", vim.cmd.TexlabForward, {silent=true, desc="Perform forward search"})
