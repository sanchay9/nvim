return {
  {
    "NvChad/nvim-colorizer.lua",
    ft = { "css", "scss" },
    cmd = "ColorizerToggle",
    opts = {
      filetypes = { "*" },
    },
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  {
    "SmiteshP/nvim-navic",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      highlight = true,
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
    },
  },

  {
    "wfxr/minimap.vim",
    cmd = "MinimapToggle",
    config = function()
      vim.g.minimap_width = 14
      vim.g.minimap_git_colors = 1
    end,
  },

  {
    "lukas-reineke/headlines.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      local opts = {}
      opts["markdown"] = {
        headline_highlights = {},
        -- disable bullets for now. See https://github.com/lukas-reineke/headlines.nvim/issues/66
        bullets = {},
      }
      for i = 1, 6 do
        local hl = "Headline" .. i
        vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
        table.insert(opts["markdown"].headline_highlights, hl)
      end
      return opts
    end,
    ft = { "markdown" },
    config = function(_, opts)
      -- PERF: schedule to prevent headlines slowing down opening a file
      vim.schedule(function()
        require("headlines").setup(opts)
        require("headlines").refresh()
      end)
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = { { "<leader>d", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "markdown preview" } },
    config = function()
      vim.cmd "do FileType"
    end,
  },

  -- {
  --   "echasnovski/mini.nvim",
  --   config = function()
  --     require("mini.align").setup()
  --   end,
  -- },
}
