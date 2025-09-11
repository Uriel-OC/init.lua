---@module "lazy.types"
---@type LazyPluginSpec[]
return {
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    opts = {
      "fzf-native",
      file_icons = "mini",
      previewers = {
        builtin = {
          snacks_image = false,
        }
      }
    }
  },
}
