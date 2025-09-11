---@type LazyPluginSpec[]
return {
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    config = function()
      local splits = require "smart-splits"

      splits.setup {
        default_amount = 2,
      }

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
      vim.g.slime_target = "wezterm"
      vim.g.slime_no_mappings = 1
      vim.g.slime_default_config = { pane_direction = "right" }
      vim.g.slime_bracketed_paste = 1
    end,
    keys = {
      { "gzz", "<Plug>SlimeLineSend", desc = "Send line to REPL" },
      {
        "gz",
        "<Plug>SlimeRegionSend",
        mode = "x",
        desc = "Send region to REPL"
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
  }
}
