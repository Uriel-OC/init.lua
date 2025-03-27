return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
    end
  },
  {
    "blink.cmp",
    opts = {
      sources = {
        per_filetype = { tex = { "lsp", "snippets", "buffer" } },
      }
    },
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
                  "-synctex=1",
                  "-shell-escape",
                  "%f"
                },
                useFileList = true,
              },
              forwardSearch = {
                executable = "displayline",
                args = { "-r", "-b", "-n", "%l", "%p", "%f" },
              },
              chktex = { onEdit = true },
              latexFormatter = "tex-fmt",
              experimental = { followPackageLinks = true },
            }
          }
        }
      }
    },
    ft = "tex"
  },
}
