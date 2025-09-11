---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.parsers, { "fortran" })
    end
  },
}
