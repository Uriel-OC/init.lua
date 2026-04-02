vim.filetype.add {
  extension = {
    stan = "stan"
  },
  filename = {
    [".latexmkrc"] = "perl",
  },
  pattern = {
    [".*/kitty/.*%.conf"] = "kitty",
  }
}
