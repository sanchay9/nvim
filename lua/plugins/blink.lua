return {
  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.default",
    },
    dependencies = {
      "Kaiser-Yang/blink-cmp-dictionary",
    },
    opts = {
      appearance = {
        nerd_font_variant = "normal",
        kind_icons = vim.tbl_extend("keep", {
          Color = "██",
        }, require("icons").kinds),
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        list = { selection = { auto_insert = true } },
        menu = {
          border = vim.g.border,
          winblend = 10,
          draw = {
            treesitter = { "lsp" },
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = vim.g.border,
          },
        },
        ghost_text = {
          enabled = false,
        },
      },
      sources = {
        default = function()
          if vim.bo.filetype == "markdown" then
            return { "dictionary", "lsp", "path", "snippets", "buffer", "markdown" }
          elseif vim.bo.filetype == "lua" then
            return { "lazydev", "lsp", "path", "snippets", "buffer" }
          end
          return { "lsp", "path", "snippets", "buffer" }
        end,
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          snippets = {
            max_items = 5,
          },
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            max_items = 5,
            score_offset = -3,
            min_keyword_length = 4,
            opts = {
              dictionary_files = { "/usr/share/dict/words" },
            },
          },
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
          },
        },
      },

      keymap = {
        preset = "default",
        ["<c-l>"] = { "snippet_forward", "fallback" },
        ["<c-h>"] = { "snippet_backward", "fallback" },
      },
    },
  },
}
