local M = {}

M.hooks_augroup = vim.api.nvim_create_augroup("PluginsHooks", { clear = true })
M.lazy_augroup = vim.api.nvim_create_augroup("LazyPlugins", { clear = true })

return M
