return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      { "<C-'>", ft = "http", "<cmd>lua require('kulala').run()<cr>", desc = "kulala run" },
      { "<leader>rc", ft = "http", "<cmd>lua require('kulala').copy()<cr>", desc = "copy curl" },
      { "<leader>ri", ft = "http", "<cmd>lua require('kulala').from_curl()<cr>", desc = "import curl" },
      { "<leader>rt", ft = "http", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "kulala toggle view" },
      { "<leader>re", "<cmd>lua require('kulala').set_selected_env()<cr>", desc = "kulala select env" },
      { "[[", ft = "http", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "prev request" },
      { "]]", ft = "http", "<cmd>lua require('kulala').jump_next()<cr>", desc = "next request" },
    },
    opts = {
      split_direction = "vertical",
      show_icons = "above_request",
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
