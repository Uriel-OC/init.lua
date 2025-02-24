return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = { "nvim-treesitter/nvim-treesitter-context" },
    opts = {
      ensure_installed = {
        -- Included parsers
        "c", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc",
        -- Popular config filetypes
        "json", "toml", "git_config", "ssh_config", "yaml",
        -- Shells
        "bash", "fish",
        -- Git
        "git_rebase", "gitattributes", "gitcommit", "gitignore",
        -- Others
        "comment", "csv", "gpg", "make", "regex", "tmux",
      },
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, },
    },
    config = function (_,opts)
      require("nvim-treesitter.configs").setup(opts)

      require("treesitter-context").setup {
          max_lines = 3,
      }
    end
  }
}
