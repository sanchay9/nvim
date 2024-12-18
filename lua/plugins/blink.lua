return {
  {
    "saghen/blink.cmp",
    version = "v0.7.6",
    event = "InsertEnter",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.default",
    },
    opts = {
      appearance = {
        nerd_font_variant = "normal",
        kind_icons = vim.tbl_extend("keep", {
          Color = "██",
        }, require("icons").icons.kinds),
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        trigger = {
          show_on_insert_on_trigger_character = false,
        },
        menu = {
          border = "none",
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
            border = "none",
          },
        },
        ghost_text = {
          enabled = false,
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      keymap = {
        preset = "default",
        ["<c-l>"] = { "snippet_forward", "fallback" },
        ["<c-h>"] = { "snippet_backward", "fallback" },
      },
    },
  },
}
