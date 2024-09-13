return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      { "<C-'>", ft = "http", "<cmd>lua require('kulala').run()<cr>", desc = "kulala run" },
      { "<leader>rc", ft = "http", "<cmd>lua require('kulala').copy()<cr>", desc = "copy curl" },
      { "<leader>rt", ft = "http", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "kulala toggle view" },
      { "<leader>re", "<cmd>lua require('kulala').set_selected_env()<cr>", desc = "kulala select env" },
      { "[r", ft = "http", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "prev request" },
      { "]r", ft = "http", "<cmd>lua require('kulala').jump_next()<cr>", desc = "next request" },
    },
    opts = {
      split_direction = "vertical",
      icons = {
        inlay = {
          loading = "󰦖",
          done = "󰦕",
          error = "󱄊",
        },
        lualine = "",
      },
    },
  },
}
