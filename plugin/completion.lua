local U = require "utils"

vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Build LuaSnip dependency",
  group = U.hooks_augroup,
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "LuaSnip" and (kind == "install" or kind == "update") then
      vim.system({ "make", "install_jsregexp" }, { cwd = ev.data.path })
    end
  end
})

vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  group = U.lazy_augroup,
  callback = function()
    vim.pack.add({
      {
        src = "https://github.com/L3MON4D3/LuaSnip",
        version = vim.version.range("2.*"),
      },
    })

    local luasnip = require "luasnip"

    luasnip.config.setup {
      update_events = { "TextChanged", "TextChangedI" },
      region_check_events = "CursorMoved",
      delete_check_events = "InsertLeave",
      enable_autosnippets = true,
    }

    require("luasnip.loaders.from_lua").lazy_load {
      paths = { "./snippets" },
      fs_event_providers = { autocmd = true, libuv = true },
    }

    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-h>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-e>", function()
      if luasnip.in_snippet() and luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end)
  end
})

vim.pack.add({
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
})

local blink = require "blink.cmp"

blink.build():pwait()

blink.setup {
  keymap = {
    preset = "none",
    ["<M-space>"] = { "show_documentation", "hide_documentation" },
    ["<C-c>"] = { "hide" },
    ["<CR>"] = { "accept", "fallback" },

    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
  },
  snippets = { preset = "luasnip" },
  completion = {
    list = {
      selection = { preselect = false, auto_insert = false },
    },
    accept = {
      auto_brackets = {
        enabled = false,
      }
    },
    menu = {
      border = "none",
      scrollbar = false,
    },
  },
  fuzzy = {
    sorts = { "score", "exact", "sort_text" },
  },
  sources = {
    default = { "lsp", "path", "snippets" },
    per_filetype = {
      lua = { "lazydev", "lsp" },
      query = { "omni", "buffer" }
    },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
      snippets = {
        opts = {
          show_autosnippets = false,
        },
      },
    },
  },
  appearance = {
    nerd_font_variant = "normal"
  },
  cmdline = { enabled = false },
}
