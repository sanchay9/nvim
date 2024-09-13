return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = false,
      sidebars = { "terminal", "qf", "help" },
      on_highlights = function(hl, c)
        -- local prompt = "#2d3149"
        -- hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
        -- hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
        -- hl.TelescopePromptNormal = { bg = prompt }
        -- hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
        -- hl.TelescopePromptTitle = { bg = prompt, fg = prompt }
        -- hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
        -- hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
        -- hl.CursorLine = { bg = "none" }
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
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        headlines = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
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
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        treesitter = true,
        which_key = true,
      },
    },
  },
}
