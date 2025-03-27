vim.loader.enable()

-- Disable some providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Setup relevant providers
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.node_host_prog = "/opt/homebrew/bin/neovim-node-host"

-- Setup TeX
vim.g.tex_flavor = "latex"

-- Are we using tmux
vim.g.using_tmux = vim.fn.exists("$TMUX") == 1

-- Load my config
require "uriel"

-- Load coloscheme
pcall(vim.cmd.colorscheme, "catppuccin")
