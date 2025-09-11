---@module "lazy.types"
---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.parsers, { "typst" })
    end
  },
  {
    "chomosuke/typst-preview.nvim",
    version = '1.*',
    opts = {
      invert_colors = "always",
      dependencies_bin = {
        tinymist = "tinymist",
        websocat = "websocat",
      },
    },
    ft = "typst",
  }
}
