-- moving around, searching and patterns
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- displaying text
vim.opt.wrap = false
vim.opt.sidescrolloff = 8
vim.opt.cmdheight = 1
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.number = true
vim.opt.relativenumber = true

-- syntax, highlighting and spelling
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- multiple windows
vim.opt.laststatus = 3
vim.opt.splitbelow = true
vim.opt.splitright = true

-- messages and info
vim.opt.showmode = false

-- editing text
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"

-- tabs and indenting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- mapping
vim.opt.timeoutlen = 300

-- the swap file
vim.opt.swapfile = false

-- various
vim.opt.signcolumn = "yes"
vim.opt.pyxversion = 3
