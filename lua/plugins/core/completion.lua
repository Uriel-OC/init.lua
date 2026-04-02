---@type LazyPluginSpec[]
return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    build = "make install_jsregexp",
    config = function()
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
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    build = "cargo build --release",
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
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
        implementation = "rust",
        sorts = { "score", "exact", "sort_text" },
      },
      sources = {
        default = { "lsp", "path", "snippets" },
        per_filetype = { lua = { "lazydev", "lsp" } },
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
    },
  }
}
