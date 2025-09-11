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
      auto_integrations = true,
    }
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      enable = {
        legacy_highlights = false,
      },
      styles = {
        transparency = true,
      },
    },
  },
}

