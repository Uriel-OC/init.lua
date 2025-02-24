return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "julia" })
    end
  },
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        julials = {
          settings = {}
        }
      }
    },
    ft = "julia",
  },
  {
    "nvim-cmp",
    opts = function (_, opts)
      vim.list_extend(opts.has_lsp, { "julia" })
    end
  },
  {
    "vim-slime",
    keys = {
      { "gzz", vim.cmd.SlimeSend, desc = "Send line to REPL", ft = "julia" },
      { "gz", ":SlimeSend<CR>", mode = "x", silent = true, desc = "Send region to REPL", ft = "julia" },
    },
  }
}
