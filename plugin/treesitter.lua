vim.g.query_lint_on = { "InsertLeave", "TextChanged" }

local hooks_group = require("utils").hooks_augroup

vim.g.no_plugin_maps = true

vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Update Tree-sitter parsers",
  group = hooks_group,
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end
})

vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
}

vim.schedule(function()
  require("treesitter-context").setup {
    max_lines = 3,
    line_numbers = false,
  }
  require("nvim-treesitter-textobjects").setup {
    move = {
      set_jumps = true,
    },
  }
end)

local parsers = {
  -- Included parsers
  "c", "lua", "markdown", "query", "vim", "vimdoc",
  -- Popular config filetypes
  "json", "ssh_config",
  -- Shells
  "bash", "fish",
  -- Git
  "diff", "git_config", "git_rebase", "gitcommit", "gitignore",
  -- Others
  "comment", "kitty", "cmake", "make", "regex",
  -- Languages
  "cpp", "julia", "python", "latex", "bibtex", "perl", "typst",
}

local ts = require "nvim-treesitter"
local tsq = vim.treesitter.query
local ts_move = require "nvim-treesitter-textobjects.move"

local installed = ts.get_installed("parsers")

local missing = vim.tbl_filter(
  function(parser) return not vim.list_contains(installed, parser) end,
  parsers
)

if #missing > 0 then
  ts.install(missing)
end

local ts_group = vim.api.nvim_create_augroup("TSOptions", { clear = true })
for _, lang in ipairs(installed) do
  local ft = vim.treesitter.language.get_filetypes(lang)
  vim.api.nvim_create_autocmd("FileType", {
    group = ts_group,
    pattern = ft,
    callback = function(ev)
      vim.treesitter.start(ev.buf, lang)

      if tsq.get(lang, "folds") ~= nil then
        local winid = vim.api.nvim_get_current_win()
        vim.wo[winid][0].foldmethod = "expr"
        vim.wo[winid][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end
      if tsq.get(lang, "indents") ~= nil then
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
      if tsq.get(lang, "textobjects") ~= nil then
        local function move_map(lhs, rhs, desc)
          vim.keymap.set({ "n", "x", "o" }, lhs, rhs,
            { silent = true, desc = "TS-TxtObj: " .. desc, buf = ev.buf })
        end
        move_map("]m", function()
          ts_move.goto_next_start("@function.outer", "textobjects")
        end, "Jump to next function start")
        move_map("[m", function()
          ts_move.goto_previous_start("@function.outer", "textobjects")
        end, "Jump to previous function start")
        move_map("]M", function()
          ts_move.goto_next_end("@function.outer", "textobjects")
        end, "Jump to next function end")
        move_map("[M", function()
          ts_move.goto_previous_end("@function.outer", "textobjects")
        end, "Jump to previous function end")
      end
    end
  })
end

local custom = {
  stan = {
    install_info = {
      url = "https://github.com/WardBrian/tree-sitter-stan",
      location = "grammars/stan",
      queries = "queries",
    },
    maintainers = { "@WardBrian" },
    tier = 2,
  },
}

vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  group = vim.api.nvim_create_augroup("CustomParsers", { clear = true }),
  callback = function()
    for parser, repo_info in pairs(custom) do
      require("nvim-treesitter.parsers")[parser] = repo_info
    end
  end
})
