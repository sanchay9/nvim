return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = false,
      sidebars = { "terminal", "qf", "help" },
      on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = c.fg }

        local colours = { c.magenta, c.cyan, c.blue }
        math.randomseed(os.time())
        hl.AlphaHeader = { bg = c.bg, fg = colours[math.random(1, #colours)] }
      end,
    },
  },

  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = true,
      integrations = {
        blink_cmp = { style = "bordered" },
        diffview = true,
        gitsigns = true,
        render_markdown = true,
        lsp_trouble = true,
        snacks = { enabled = true },
        mason = true,
        overseer = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true },
        grug_far = true,
        neotest = true,
        dap = true,
        neogit = true,
        noice = true,
        treesitter_context = true,
      },
    },
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    build = ":KanagawaCompile",
    opts = {
      transparent = true,
      background = {
        dark = "wave",
        light = "lotus",
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
  },

  {
    "sainnhe/gruvbox-material",
    lazy = true,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
}
