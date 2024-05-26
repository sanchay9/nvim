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
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
          require("nvim-autopairs").setup {
            check_ts = true,
            ts_config = {
              lua = { "string", "source" },
              javascript = { "string", "template_string" },
            },
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
      local luasnip = require "luasnip"
      require("cmp_dictionary").setup {
        paths = { "/usr/share/dict/words" },
        first_case_insensitive = true,
        document = {
          enable = true,
          command = { "wn", "${label}", "-over" },
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
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- manually trigger completion
          ["<C-y>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
          ["<C-e>"] = cmp.mapping.abort(),
          ["<S-CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
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
            border = border "CmpBorder",
            side_padding = 2,
            scrollbar = true,
          },
          documentation = {
            border = border "CmpDocBorder",
          },
        },
        -- formatting = {
        --   fields = { "abbr", "kind", "menu" },
        --   format = function(_, item)
        --     local icons = require("plugins.configs.icons").lspkind
        --     item.kind = string.format("%s %s", (" " .. icons[item.kind] .. " "), item.kind)
        --
        --     -- item.menu = ({
        --     --   nvim_lsp = "[LSP]",
        --     --   nvim_lua = "[Lua]",
        --     --   luasnip = "[Snippet]",
        --     --   buffer = "[Buffer]",
        --     --   path = "[Path]",
        --     -- })[_.source.name]
        --
        --     return item
        --   end,
        -- },
        formatting = { -- vscode
          fields = { "kind", "abbr" },
          format = function(_, item)
            local icons = require("plugins.configs.icons").lspkind
            item.abbr = string.sub(item.abbr, 1, 30)
            item.kind = icons[item.kind] or ""
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      }
    end,
  },
}
