return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = true,
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
        blink_cmp = true,
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
      undercurl = true,
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      background = {
        dark = "wave",
        light = "lotus",
      },
    },
  },
}
