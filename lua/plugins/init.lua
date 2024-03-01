return {
  { "nvim-lua/plenary.nvim", lazy = true },

  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup {
        filetypes = {
          "*",
          "!NvimTree",
        },
      }

      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    -- opts = function()
    --   return { override = require("plugins.configs.icons").devicons }
    -- end,
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  {
    "olexsmir/gopher.nvim",
    event = "VeryLazy",
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup {
        ignore = "^$",
        mappings = {
          extra = false,
        },
      }
    end,
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },

  {
    "SmiteshP/nvim-navic",
    opts = {
      highlight = true,
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
    },
  },

  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree Toggle" } },
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
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = { { "<leader>d", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" } },
    config = function()
      vim.cmd "do FileType"
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    config = function()
      require("copilot").setup {
        suggestion = {
          auto_trigger = false,
          keymap = {
            accept = "<M-Enter>",
            next = "<M-\\>",
            prev = "<M-S-\\>",
            dismiss = "<M-Backspace>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
        },
      }
    end,
  },

  { "folke/neodev.nvim", opts = {} },

  {
    "Bekaboo/dropbar.nvim",
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      timeout = 1000,
      render = "minimal",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      vim.notify = require "notify"
    end,
  },
}
