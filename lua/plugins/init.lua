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
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      style = "glyph", -- 'glyph' or 'ascii'
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
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
    -- "echasnovski/mini.map",
    -- "Isrothy/neominimap.nvim",
    -- setup = function()
    --   require("mini.map").setup()
    -- end,
    -- opts = {
    --   -- Highlight integrations (none by default)
    --   integrations = nil,
    --
    --   -- Symbols used to display data
    --   symbols = {
    --     -- Encode symbols. See `:h MiniMap.config` for specification and
    --     -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
    --     -- Default: solid blocks with 3x2 resolution.
    --     encode = nil,
    --
    --     -- Scrollbar parts for view and line. Use empty string to disable any.
    --     scroll_line = "█",
    --     scroll_view = "┃",
    --   },
    --
    --   -- Window options
    --   window = {
    --     -- Whether window is focusable in normal way (with `wincmd` or mouse)
    --     focusable = false,
    --
    --     -- Side to stick ('left' or 'right')
    --     side = "right",
    --
    --     -- Whether to show count of multiple integration highlights
    --     show_integration_count = true,
    --
    --     -- Total width
    --     width = 10,
    --
    --     -- Value of 'winblend' option
    --     winblend = 25,
    --
    --     -- Z-index
    --     zindex = 10,
    --   },
    -- },
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
