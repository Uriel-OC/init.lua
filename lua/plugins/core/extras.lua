return {
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    cond = vim.g.using_tmux,
    opts = {
      move_cursor_same_row = true,
      multiplexer_integration = "tmux",
    },
    config = function(_, opts)
      local splits = require "smart-splits"

      splits.setup(opts)

      vim.keymap.set({ "n", "i" }, "<M-h>", splits.move_cursor_left)
      vim.keymap.set({ "n", "i" }, "<M-j>", splits.move_cursor_down)
      vim.keymap.set({ "n", "i" }, "<M-k>", splits.move_cursor_up)
      vim.keymap.set({ "n", "i" }, "<M-l>", splits.move_cursor_right)
      vim.keymap.set("n", "<C-Left>", splits.resize_left)
      vim.keymap.set("n", "<C-Down>", splits.resize_down)
      vim.keymap.set("n", "<C-Up>", splits.resize_up)
      vim.keymap.set("n", "<C-Right>", splits.resize_right)
    end
  },
  {
    "folke/trouble.nvim",
    opts = { focus = true, },
    cmd = "Trouble",
    keys = {
      {
        "<leader>tt",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
    },
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    init = function ()
      vim.g.undotree_WindowLayout = 4
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_TreeNodeShape = "✱"
      vim.g.undotree_TreeReturnShape = "╲"
      vim.g.undotree_TreeVertShape = "│"
      vim.g.undotree_TreeSplitShape = "╱"
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_UndoDir = vim.o.undodir
    end,
    keys = {
      { "<leader><leader>", vim.cmd.UndotreeToggle, desc = "Toggle undotree"}
    }
  },
  {
    "jpalardy/vim-slime",
    cmd = "SlimeSend",
    init = function ()
      vim.g.slime_target = "tmux"
      vim.g.slime_no_mappings = 1
      vim.g.slime_preserve_curpos = 0
      vim.g.slime_default_config = { socket_name= "default", target_pane= "{last}" }
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
    end,
  }
}
