---@module "lazy.types"
---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end
  },
  {
    "vim-slime",
    keys = {
      { "gzz", vim.cmd.SlimeSend, desc = "Send line to REPL", ft = "python" },
      { "gz", ":SlimeSend<CR>", mode = "x", silent = true, desc = "Send region to REPL", ft = "python" },
    },
  }
}
