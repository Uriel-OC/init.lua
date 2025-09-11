vim.filetype.add {
  extension = {
    stan = "stan"
  }
}

local treesitter_ok, _ = pcall(require, "nvim-treesitter")

if not treesitter_ok then
  return
end

local ts_group = vim.api.nvim_create_augroup("MoreParsers", { clear = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  group = ts_group,
  once = true,
  callback = function()
    require("nvim-treesitter.parsers").stan = {
      install_info = {
        revision = "8f42a13095951700e7f9597dc309bee2c390c51f",
        url = "https://github.com/WardBrian/tree-sitter-stan",
        queries = "queries",
      },
      maintainers = { "@WardBrian" },
      tier = 2,
    }
  end
})

