return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavor = "mocha",
      custom_highlights = function(colors)
        return {
          ColorColumn = { bg = colors.mantle },
        }
      end,
      integrations = {
        fidget = true,
        snacks = { enabled = true },
        lsp_trouble = true,
      },
    }
  }
}
