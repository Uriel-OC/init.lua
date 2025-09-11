vim.treesitter.start()

vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.wo[0][0].colorcolumn = "80"

vim.bo.formatprg = "tex-fmt"

-- vim.cmd.compiler("make")
-- vim.bo.makeprg = "make -j6 -l6 -f main.makefile"

require("utils").create_spell_keymap()
