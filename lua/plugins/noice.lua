return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == "lazy" then
        vim.cmd [[messages clear]]
      end
      require("noice").setup(opts)
    end,
    opts = function()
      local ret = {
        cmdline = {
          opts = {
            border = {
              style = vim.g.conf.border,
              text = {
                top = "",
              },
            },
          },
          format = {
            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = " ", lang = "lua" },
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            input = { view = "cmdline_popup", icon = "󰥻 " }, -- Used by input()
          },
        },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "%d+L, %d+B" },
                { find = "; after #%d+" },
                { find = "; before #%d+" },
              },
            },
            view = "mini",
          },
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "Agent service not initialized" },
              },
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "client.supports_method is deprecated" },
              },
            },
            opts = { skip = true },
          },
        },
        presets = {
          bottom_search = false,
          command_palette = false,
          long_message_to_split = true,
          inc_rename = true,
          lsp_doc_border = true,
        },
      }

      if vim.g.conf.border == "none" then
        ret.cmdline.opts.border.padding = { "1", "2" }
        ret.views = {
          cmdline_popup = {
            win_options = {
              winhighlight = {
                Normal = "NormalFloat",
                FloatBorder = "FloatBorder",
              },
            },
          },
        }
      end
      return ret
    end,
  },

  { "MunifTanjim/nui.nvim", lazy = true },
}
