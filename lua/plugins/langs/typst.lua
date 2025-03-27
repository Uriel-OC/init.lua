return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "typst" })
    end
  },
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {}
      }
    },
    ft = "typst",
  },
}
