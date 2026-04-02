local winin = vim.api.nvim_get_current_win()

vim.wo[winin][0].foldmethod = "marker"
