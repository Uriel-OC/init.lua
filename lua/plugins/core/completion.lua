return {
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter" , "CmdlineEnter" },
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "https://codeberg.org/FelipeLema/cmp-async-path",

      -- "dmitmel/cmp-digraphs"
    },
    opts = { has_lsp = {} },
    config = function(_, opts)
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

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

      vim.keymap.set({"i", "s"}, "<C-l>", function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { silent = true })
      vim.keymap.set({"i", "s"}, "<C-h>", function()
        if luasnip.locally_jumpable(-1) then
          luasnip.locally_jump(-1)
        end
      end, { silent = true })
      vim.keymap.set({"i", "s"}, "<C-e>", function()
        if luasnip.in_snippet() and luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end)

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert,noselect' },
        view = {
          entries = { name = 'custom', selection_order = 'near_cursor'},
          docs = { auto_open = false }
        },
        window = {
          documentation = cmp.config.window.bordered(),
          completion = { scrollbar = false },
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = function(fallback)
            if cmp.visible() then
              if cmp.visible_docs() then
                cmp.close_docs()
              else
                cmp.open_docs()
              end
            else
              fallback()
            end
          end,
          ["<Enter>"] = function(fallback)
            if cmp.visible() then cmp.confirm() else fallback() end
          end,
          ["<C-c>"] = function(fallback)
            if cmp.visible() then cmp.abort() else fallback() end
          end
        },
        formatting = {
          expandable_indicator = false,
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            -- Kind
            local icon, hl
            if entry.source.name == "nvim_lsp" then
              icon, hl, _ = MiniIcons.get("lsp", vim_item.kind)
            elseif entry.source.name == "lazydev" then
              icon = "󰒲"
              hl = "MiniIconsAzure"
            elseif entry.source.name == "luasnip" then
              icon, hl, _ = MiniIcons.get("lsp", "snippet")
            elseif entry.source.name == "buffer" then
              icon, hl, _ = MiniIcons.get("lsp", "text")
            elseif entry.source.name == "async_path" then
              if entry.completion_item.label:find("%w+%.%w+") then
                icon, hl, _ = MiniIcons.get("file", entry.completion_item.label)
              else
                icon, hl, _ = MiniIcons.get("directory", entry.completion_item.label)
              end
            else
              icon = "󰷻"
              hl = "MiniIconsGrey"
            end
            vim_item.kind = icon
            vim_item.kind_hl_group = hl
            -- Menu
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              lazydev = "[LazyDev]",
              luasnip = "[LuaSnip]",
              buffer = "[Buffer]",
              async_path = "[Path]",
              nvim_lsp_signature_help = "[SigHelp]"
            })[entry.source.name]
            return vim_item
          end
        },
        sources = {
          { name = "luasnip" },
          { name = "buffer" },
          { name = "async_path" }
        },
      }

      cmp.setup.filetype("lua", {
        sources = {
          { name = "lazydev", group = 0 },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "async_path" },
          { name = 'nvim_lsp_signature_help' }
        }
      })

      for _, ft in ipairs(opts.has_lsp) do
        cmp.setup.filetype(ft, {
          sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "async_path" },
            { name = 'nvim_lsp_signature_help' }
          }
        })
      end

      cmp.setup.cmdline({ "/", "?" }, {
        view = {
          entries = { name = 'wildmenu', separator = '|' }
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } }
      })
      cmp.setup.cmdline(":", {
        view = {
          entries = { name = 'wildmenu', separator = '|' }
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          {
            name = "cmdline",
            option = { treat_trailing_slash = false },
          },
          {
            name = "async_path",
            option = { trailing_slash = true }
          }
        }
      })
    end,
  },
}
