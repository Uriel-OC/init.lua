---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      parsers = {
        -- Included parsers
        "c", "lua", "markdown", "query", "vim", "vimdoc",
        -- Popular config filetypes
        "json", "ssh_config",
        -- Shells
        "bash", "fish", "zsh",
        -- Git
        "git_config", "git_rebase", "gitcommit", "gitignore",
        -- Others
        "comment", "csv", "make", "regex", "tmux",
      },
    },
    config = function(_, opts)
      local ts = require "nvim-treesitter"

      local installed_parsers = ts.get_installed()

      local parsers_to_install = vim.iter(opts.parsers)
          :filter(function(parser) return not vim.tbl_contains(installed_parsers, parser) end)
          :totable()

      if #parsers_to_install > 0 then
        ts.install(parsers_to_install)
      end

      local ts_group = vim.api.nvim_create_augroup("TSOptions", { clear = true })
      for _, lang in ipairs(opts.parsers) do
        local ft = vim.treesitter.language.get_filetypes(lang)
        vim.api.nvim_create_autocmd("Filetype", {
          group = ts_group,
          pattern = ft,
          callback = function(event)
            vim.treesitter.start(event.buf, lang)

            local tsq = vim.treesitter.query

            local has_folds, _ = pcall(tsq.get, lang, "folds")
            if has_folds then
              local winid = vim.api.nvim_get_current_win()
              vim.wo[winid][0].foldmethod = "expr"
              vim.wo[winid][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            end
            local has_indents, _ = pcall(tsq.get, lang, "indents")
            if has_indents then
              vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          end
        })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        group = vim.api.nvim_create_augroup("MoreParsers", { clear = true }),
        once = true,
        callback = function()
          for extra_lang, repo_opts in pairs(opts.extra_parsers) do
            require("nvim-treesitter.parsers")[extra_lang] = repo_opts
          end
        end
      })
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
