return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "▏", -- '▏', '┊', '|', '¦', '┆'
        -- tab_char = { "󰌒" },
      },
    },
  },

  -- {
  --   "nvimdev/indentmini.nvim",
  --   opts = {
  --     char = "▏", -- '▏', '┊', '|', '¦', '┆'
  --   },
  -- },
}
