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
      { "archie-judd/blink-cmp-words" },
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
          border = vim.g.conf.border,
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
            border = vim.g.conf.border,
          },
        },
        ghost_text = {
          enabled = false,
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          markdown = { "thesaurus", "lsp", "path", "snippets", "buffer", "markdown" },
          gitcommit = { "thesaurus", "buffer", "snippets" },
          text = { "dictionary" },
        },
        providers = {
          snippets = {
            max_items = 5,
          },
          thesaurus = {
            name = "blink-cmp-words",
            module = "blink-cmp-words.thesaurus",
            max_items = 5,
            opts = {
              score_offset = 0,
              definition_pointers = { "!", "&", "^" },
            },
          },
          dictionary = {
            name = "blink-cmp-words",
            module = "blink-cmp-words.dictionary",
            max_items = 5,
            opts = {
              dictionary_search_threshold = 3,
              score_offset = 0,
              definition_pointers = { "!", "&", "^" },
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
