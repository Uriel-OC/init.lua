vim.loader.enable()

-- Disable providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Setup TeX
vim.g.tex_flavor = "latex"

-- Load my config
require "options"
require "keymaps"
require "autocommands"
require "lazy"
require "lsp"

-- Load coloscheme
pcall(vim.cmd.colorscheme, "rose-pine")
