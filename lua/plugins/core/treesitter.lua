---@module "lazy.types"
---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        -- Included parsers
        "c", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc",
        -- Popular config filetypes
        "json", "toml", "ssh_config", "yaml",
        -- Shells
        "bash", "fish",
        -- Git
        "git_config", "git_rebase", "gitcommit", "gitignore",
        -- Others
        "comment", "csv", "gpg", "make", "regex", "tmux",
      },
    },
    config = function(_, opts)
      local ts = require "nvim-treesitter"

      local installed_parsers = ts.get_installed()

      local parsers_to_install = vim.iter(opts.parsers)
          :filter(function(parser) return not vim.tbl_contains(installed_parsers, parser) end)
          :totable()

      ts.install(parsers_to_install)
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    name = "treesitter-context",
    opts = {
      max_lines = 3,
      line_numbers = false,
    },
  },
}
