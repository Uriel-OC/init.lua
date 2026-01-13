vim.b.did_ftplugin = 1

vim.bo.commentstring = "% %s"

vim.bo.formatoptions = "r"
vim.bo.formatlistpat = [[^\s*\\\<item\>\s]]
vim.bo.formatprg = "tex-fmt --stdin -q"
