---@type LazyPluginSpec
return {
  "nvim-treesitter",
  opts = {
    extra_parsers = {
      stan = {
        install_info = {
          url = "https://github.com/WardBrian/tree-sitter-stan",
          queries = "queries",
        },
        maintainers = { "@WardBrian" },
        tier = 2,
      },
    },
  },
}
