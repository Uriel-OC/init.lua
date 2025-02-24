return {
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    opts = {
      vim.g.using_tmux and "fzf-tmux" or "fzf-native",
      file_icons = "mini",
    },
    config = function(_,opts)
      local fzf = require "fzf-lua"
      fzf.setup(opts)
      fzf.register_ui_select()
    end
  }
}
