---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.parsers, { "yaml" })
    end
  },
  {
    "cuducos/yaml.nvim",
    ft = "yaml",
  }
}
