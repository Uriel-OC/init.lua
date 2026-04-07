vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Update Tree-sitter parsers",
  group = require("utils").hooks_augroup,
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      vim.cmd("TSUpdate")
    end
  end
})

vim.g.no_plugin_maps = true

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

local context = require "treesitter-context"

vim.schedule(function()
  context.setup {
    max_lines = 3,
    line_numbers = false,
  }
  require("nvim-treesitter-textobjects").setup {
    move = {
      set_jumps = true,
    },
  }
end)

require("utils").add_parsers {
  -- Included parsers
  "c", "lua", "markdown", "query", "vim", "vimdoc",
  -- Popular config filetypes
  "json", "ssh_config",
  -- Shells
  "bash", "fish", "zsh",
  -- Git
  "git_config", "git_rebase", "gitcommit", "gitignore",
  -- Others
  "comment", "csv", "kitty", "make", "regex", "tmux",
}

local ts = require "nvim-treesitter"
local tsq = vim.treesitter.query
local ts_move = require "nvim-treesitter-textobjects.move"

local ts_group = vim.api.nvim_create_augroup("TSOptions", { clear = true })
for _, lang in ipairs(ts.get_installed("parsers")) do
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

vim.schedule(function()
  local installed = ts.get_installed("parsers")

  local missing = require("utils").get_ts_parsers()
      :filter(function(parser) return not vim.tbl_contains(installed, parser) end)
      :totable()

  if #missing > 0 then
    ts.install(missing)
  end
end)

vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  group = vim.api.nvim_create_augroup("MoreParsers", { clear = true }),
  once = true,
  callback = function()
    local custom_parsers = require("utils").get_custom_ts_parsers()

    for parser, repo_info in pairs(custom_parsers) do
      require("nvim-treesitter.parsers")[parser] = repo_info
    end
  end
})
