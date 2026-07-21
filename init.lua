-- Enable experimental features
vim.loader.enable()

require("vim._core.ui2").enable {
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      empty = "cmd",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      list_cmd = "pager",
      lua_error = "pager",
      lua_print = "msg",
      progress = "msg",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      -- typed_cmd = "cmd"
    },
    cmd = {
      height = 0.5
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.3,
      timeout = 5000,
    },
    pager = {
      height = 0.5,
    },
  },
}

-- Disable built-in plugins
local disabled_builtins = {
  "gzip",
  "matchit",
  "matchparen",
  "tarPlugin",
  "tutor",
  "zipPlugin",
}
for _, plugin in ipairs(disabled_builtins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Disable providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Setup TeX
vim.g.tex_flavor = "latex"

-- Setup colorscheme
vim.pack.add({{
  src = "https://github.com/rose-pine/neovim",
  name = "rose-pine"
}})

require("rose-pine").setup {
  dim_inactive_windows = true,
  enable = {
    terminal = false,
    legacy_highlights = false,
  },
  highlight_groups = {
    TreesitterContext = { bg = "base" },
    TreesitterContextLineNumber = { fg = "muted", bg = "base" },
    TreesitterContextBottom = { sp = "muted", underline = true },
  }
}

vim.cmd.colorscheme("rose-pine")
