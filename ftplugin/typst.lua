vim.b.did_ftplugin = 1

vim.opt.wildignore:append("*.pdf")

vim.bo.commentstring = "// %s"

vim.bo.formatoptions = "tcrn"
vim.bo.formatlistpat = [[^\s*\%(\d\+\.\|[-+/]\)\s]]
