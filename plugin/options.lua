-- moving around, searching and patterns
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- displaying text
vim.o.smoothscroll = true
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.sidescrolloff = 8
vim.o.fillchars = "fold: "
vim.o.cmdheight = 1
vim.o.lazyredraw = true
vim.o.list = true
vim.o.listchars = "tab:» ,trail:·,nbsp:␣"
vim.o.number = true
vim.o.relativenumber = true

-- syntax, highlighting and spelling
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- multiple windows
vim.o.laststatus = 3
vim.o.splitbelow = true
vim.o.splitright = true

-- messages and info
vim.o.showmode = false

-- editing text
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"

-- tabs and indenting
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true

-- folding
vim.o.foldlevel = 99
vim.o.foldtext = ""

-- mapping
vim.o.timeoutlen = 300

-- the swap file
vim.o.swapfile = false
vim.o.updatetime = 250

-- command line editing
vim.opt.wildignore:append(".DS_Store")

-- various
vim.o.signcolumn = "yes"
vim.o.pyxversion = 3
vim.o.winborder = "rounded"
