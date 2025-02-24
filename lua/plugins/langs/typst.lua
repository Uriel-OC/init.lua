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
        tinymist = {
          settings = {}
        }
      }
    },
    ft = "typst",
  },
  {
    "nvim-cmp",
    opts = function (_, opts)
      vim.list_extend(opts.has_lsp, { "typst" })
    end
  },
}
