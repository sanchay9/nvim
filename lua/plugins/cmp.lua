return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("luasnip").config.set_config {
            history = true,
            updateevents = "TextChanged,TextChangedI",
          }

          require("luasnip/loaders/from_snipmate").lazy_load { paths = { "~/.config/nvim/snippets" } }
          require("luasnip").filetype_extend("all", { "_" })

          vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
              if
                require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                and not require("luasnip").session.jump_active
              then
                require("luasnip").unlink_current()
              end
            end,
          })
        end,
      },

      {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
      },

      {
        "windwp/nvim-autopairs",
        enabled = false,
        config = function()
          require("nvim-autopairs").setup {
            check_ts = true,
            ts_config = {
              lua = { "string", "source" },
              javascript = { "string", "template_string" },
            },
            fast_wrap = {},
          }

          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "uga-rosa/cmp-dictionary",
    },

    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      local function border(hl_name)
        return {
          { "╭", hl_name },
          { "─", hl_name },
          { "╮", hl_name },
          { "│", hl_name },
          { "╯", hl_name },
          { "─", hl_name },
          { "╰", hl_name },
          { "│", hl_name },
        }
      end

      local cmp = require "cmp"
      local dict = require "cmp_dictionary"
      dict.setup {
        exact = 2,
        first_case_insensitive = false,
        document = false,
        document_command = "wn %s -over",
        async = false,
        sqlite = false,
        max_items = -1,
        capacity = 5,
        debug = false,
      }
      dict.switcher {
        spelllang = {
          en = "~/.cache/en.dict",
        },
      }

      cmp.setup.filetype("markdown", {
        sources = cmp.config.sources({
          { name = "dictionary" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.filetype("lua", {
        sources = cmp.config.sources({
          { name = "nvim_lua" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })

      return {
        completion = {
          completeopt = "menu,menuone",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
          ["<S-CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        window = {
          completion = {
            -- border = border "CmpBorder",
            side_padding = 2,
            scrollbar = true,
          },
          documentation = {
            -- border = border "CmpDocBorder",
          },
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(_, item)
            local icons = require("plugins.configs.icons").lspkind
            item.kind = string.format("%s %s", (" " .. icons[item.kind] .. " "), item.kind)

            -- item.menu = ({
            --   nvim_lsp = "[LSP]",
            --   nvim_lua = "[Lua]",
            --   luasnip = "[Snippet]",
            --   buffer = "[Buffer]",
            --   path = "[Path]",
            -- })[_.source.name]

            return item
          end,
        },
        -- formatting = { -- vscode
        --   fields = { "kind", "abbr" },
        --   format = function(_, item)
        --     local icons = require("plugins.configs.icons").lspkind
        --     item.abbr = string.sub(item.abbr, 1, 30)
        --     item.kind = icons[item.kind] or ""
        --     return item
        --   end,
        -- },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      }
    end,
  },
}
