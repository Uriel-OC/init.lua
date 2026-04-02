---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.parsers, { "bibtex", "latex", "perl" })
    end
  },
  {
    "blink.cmp",
    opts = {
      sources = {
        per_filetype = { tex = { "lsp", "snippets" } },
      }
    },
  },
}
