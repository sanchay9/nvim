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
        hl.FzfLuaBorder = { fg = c.blue }

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
      transparent_background = false,
      integrations = {
        alpha = true,
        -- blink_cmp = {
        --   style = "bordered",
        -- },
        diffview = true,
        fzf = true,
        gitsigns = true,
        illuminate = { enabled = true },
        markdown = true,
        render_markdown = true,
        lsp_trouble = true,
        snacks = true,
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
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        dap = true,
        neogit = true,
        noice = true,
        semantic_tokens = true,
        treesitter = true,
        treesitter_context = true,
      },
    },
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    build = ":KanagawaCompile",
    opts = {
      transparent = false,
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
