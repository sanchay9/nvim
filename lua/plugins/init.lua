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
      depth_limit_indicator = require("icons").misc.depth_indicator,
      safe_output = true,
    },
  },
}
