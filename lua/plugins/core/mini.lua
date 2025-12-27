---@type LazyPluginSpec[]
return {
  {
    "echasnovski/mini.icons",
    event = "VeryLazy",
    opts = {}
  },
  {
    "echasnovski/mini.hipatterns",
    keys = {
      {
        "<leader>tc",
        function()
          local patterns = require "mini.hipatterns"
          patterns.toggle(0, {
            highlighters = {
              hex_color = patterns.gen_highlighter.hex_color(),
            },
          })
        end,
        silent = true,
        desc = "Toggle color highlighter"
      }
    }
  },
  {
    "echasnovski/mini.statusline",
    event = "VeryLazy",
    opts = {
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
  },
  {
    "echasnovski/mini-git",
    main = "mini.git",
    event = "VeryLazy",
    opts = {}
  },
  {
    "echasnovski/mini.diff",
    event = "VeryLazy",
    opts = {}
  },
}
