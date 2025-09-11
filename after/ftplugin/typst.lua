vim.treesitter.start()

vim.wo[0][0].colorcolumn = "80"
vim.bo.commentstring = "// %s"

vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.lsp.foldexpr()"

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

require("utils").create_spell_keymap()
