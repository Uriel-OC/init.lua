---@type LazyPluginSpec[]
return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.parsers, { "rust" })
    end
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    init = function()
      ---@type rustaceanvim.Opts
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "K", "<Cmd>RustLsp hover actions<CR>", { silent = true, buffer = bufnr })
            vim.keymap.set("n", "gra", function()
              vim.cmd.RustLsp("codeAction")
            end, { silent = true, buffer = bufnr })
          end,
          standalone = false,
        },
        tools = {
          code_actions = {
            ui_select_fallback = true,
            keys = {
              confirm = "<CR>",
              quit = "q",
            }
          }
        }
      }
    end
  }
}
