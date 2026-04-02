---@type LazyPluginSpec[]
return {
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    opts = {
      default_amount = 2,
    },
    config = function(_, opts)
      local splits = require "smart-splits"

      splits.setup(opts)

      vim.keymap.set({ "n", "i" }, "<M-h>", splits.move_cursor_left)
      vim.keymap.set({ "n", "i" }, "<M-j>", splits.move_cursor_down)
      vim.keymap.set({ "n", "i" }, "<M-k>", splits.move_cursor_up)
      vim.keymap.set({ "n", "i" }, "<M-l>", splits.move_cursor_right)
      vim.keymap.set("n", "<C-S-Left>", splits.resize_left)
      vim.keymap.set("n", "<C-S-Down>", splits.resize_down)
      vim.keymap.set("n", "<C-S-Up>", splits.resize_up)
      vim.keymap.set("n", "<C-S-Right>", splits.resize_right)
    end
  },
  {
    "folke/trouble.nvim",
    opts = { focus = true, },
    keys = {
      {
        "<leader>tt",
        "<Cmd>Trouble diagnostics toggle<CR>",
        desc = "Diagnostics (Trouble)",
      },
    },
  },
  {
    "mbbill/undotree",
    init = function()
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
      {
        "<leader><leader>",
        "<Cmd>UndotreeToggle<CR>",
        desc = "Toggle undotree"
      }
    }
  },
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "kitty"
      vim.g.slime_no_mappings = 1
      vim.g.slime_bracketed_paste = 1
    end,
    keys = {
      { "gzz", "<Plug>SlimeLineSend", desc = "Send {count} line(s) to REPL" },
      { "gz", "<Plug>SlimeMotionSend", desc = "Send {motion} text to REPL" },
      {
        "gz",
        "<Plug>SlimeRegionSend",
        mode = "x",
        desc = "Send {visual} text to REPL"
      },
    },
  },
  {
    "tpope/vim-dispatch",
    init = function()
      vim.g.dispatch_no_maps = 1
    end,
    keys = {
      {
        "mm",
        "<Cmd>Make!<CR>",
        silent = true,
        desc = "Asynchronous build"
      },
      { "m<Space>", ":Make! ", desc = "Pass arguments to :Make!" },
    },
  },
  {
    "andymass/vim-matchup",
    opts = {
      matchparen = {
        deferred = true,
        offscreen = {},
      },
      text_obj = {
        enabled = false,
      },
      treesitter = {
        stopline = 500,
      }
    }
  }
}
