vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
})


local patterns = require "mini.hipatterns"
vim.keymap.set("n", "<leader>tc", function()
  patterns.toggle(0, {
    highlighters = {
      hex_color = patterns.gen_highlighter.hex_color(),
    },
  })
end, { silent = true, desc = "Toggle color highlighter" })

vim.schedule(function()
  require("mini.icons").setup()

  require("mini.input").setup()

  require("mini.ai").setup()
  require("mini.surround").setup()

  require("mini.git").setup()
  require("mini.diff").setup()

  require("mini.statusline").setup {
    content = {
      active = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
        local git           = MiniStatusline.section_git({ trunc_width = 40 })
        local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
        local diagnostics   = MiniStatusline.section_diagnostics({
          trunc_width = 75,
          signs = { ERROR = ' ', WARN = ' ', INFO = ' ', HINT = ' ' }
        })
        local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
        local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
        local location      = MiniStatusline.section_location({ trunc_width = 75 })

        local ft_icon, _, _ = MiniIcons.get("filetype", vim.bo.filetype)

        local fileinfo      = ('%s[%s]'):format(
          vim.bo.fileencoding or vim.bo.encoding, vim.bo.fileformat
        )

        return MiniStatusline.combine_groups({
          -- Right
          { hl = mode_hl,                 strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { lsp, diagnostics } },
          -- Center
          "%<",
          { hl = "MiniStatuslineFilename", strings = { "%=", ft_icon } },
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          -- Left
          '%=',
          { hl = 'MiniStatuslineFilename', strings = { location } },
          { hl = 'MiniStatuslineFileinfo', strings = { git, diff } },
          { hl = mode_hl,                  strings = { fileinfo } },
        })
      end
    }
  }

  require("mini.pick").setup()
end)

vim.api.nvim_create_autocmd("User",{
  pattern = "MiniGitCommandSplit",
  callback = function(ev)
    if ev.data.git_subcommand ~= "log" then return end

    local buf_stdout = vim.api.nvim_win_get_buf(ev.data.win_stdout)
    vim.api.nvim_open_term(buf_stdout, {})
  end
})
