---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.parsers, { "bibtex", "latex" })
    end
  },
  {
    "blink.cmp",
    opts = {
      sources = {
        per_filetype = { tex = { "lsp", "buffer", "snippets" } },
      }
    },
  },
}
