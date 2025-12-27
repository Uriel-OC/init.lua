vim.filetype.add {
  extension = {
    stan = "stan"
  },
  filename = {
    [".latexmkrc"] = "perl",
  }
}

require "uriel.options"
require "uriel.keymaps"
require "uriel.autocommands"
require "uriel.lazy"
require "uriel.lsp"
