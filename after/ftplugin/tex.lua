vim.wo[0][0].colorcolumn = "80"

vim.bo.formatprg = "tex-fmt --stdin -q"

require("utils").create_spell_keymap()
