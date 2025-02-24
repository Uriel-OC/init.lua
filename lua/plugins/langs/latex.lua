return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
    end
  },
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              build = {
                args = {
                  "-lualatex",
                  "-interaction=nonstopmode",
                  "-synctex=9",
                  "-shell-escape",
                  "%f"
                },
              },
              forwardSearch = {
                executable = "displayline",
                args = { "-r", "-b", "-n", "%l", "%p", "%f" },
              },
              chktex = { onEdit = true },
              completion = { matcher = "prefix-ignore-case" },
              experimental = { followPackageLinks = true },
            }
          }
        }
      }
    },
    ft = "tex"
  },
  {
    "nvim-cmp",
    opts = function (_, opts)
      vim.list_extend(opts.has_lsp, { "tex" })
    end
  },
}
