---@type LazyPluginSpec[]
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavor = "mocha",
      custom_highlights = function(C)
        return {
          ColorColumn = { bg = C.mantle },
          Folded = { bg = C.mantle },
        }
      end,
      default_integrations = false,
      auto_integrations = true,
    }
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
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
    },
  },
}

