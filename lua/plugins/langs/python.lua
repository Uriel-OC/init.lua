return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end
  },
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        ruff = {}
      }
    },
    ft = "python",
  },
  {
    "vim-slime",
    keys = {
      { "gzz", vim.cmd.SlimeSend, desc = "Send line to REPL", ft = "python" },
      { "gz", ":SlimeSend<CR>", mode = "x", silent = true, desc = "Send region to REPL", ft = "python" },
    },
  }
}
