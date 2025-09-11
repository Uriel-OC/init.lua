---@type LazyPluginSpec[]
return {
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      progress = {
        display = { progress_icon = { "dots_snake" } }
      },
      notification = {
        window = {
          winblend = 0,
        },
      }
    }
  },
  {
    "folke/lazydev.nvim",
    opts = {
      library = {
        { path = "lazy.nvim", words = { "LazyPluginSpec" } },
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "mini.icons",         words = { "MiniIcons" } },
        { path = "mini.statusline",    words = { "MiniStatusline" } },
        { path = "mini-git",           words = { "MiniGit" } },
        { path = "mini.diff",          words = { "MiniDiff" } },
      },
      integrations = {
        lspconfig = false,
        cmp = false,
      },
    },
  },
}
