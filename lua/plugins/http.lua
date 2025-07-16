return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      { "<C-'>", ft = "http", "<cmd>w | lua require('kulala').run()<cr>", desc = "kulala run" },
      { "<leader>rc", ft = "http", "<cmd>lua require('kulala').copy()<cr>", desc = "copy curl" },
      { "<leader>ri", ft = "http", "<cmd>lua require('kulala').from_curl()<cr>", desc = "import curl" },
      { "<leader>rt", ft = "http", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "kulala toggle view" },
      { "<leader>re", "<cmd>lua require('kulala').set_selected_env()<cr>", desc = "kulala select env" },
      { "<leader>rr", "<cmd>lua require('kulala').search()<cr>", desc = "kulala search request" },
      { "[[", ft = "http", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "prev request" },
      { "]]", ft = "http", "<cmd>lua require('kulala').jump_next()<cr>", desc = "next request" },
    },
    opts = {
      ui = {
        split_direction = "vertical",
        default_view = "body",
        winbar = false,
        show_icons = "signcolumn",
        icons = {
          inlay = {
            loading = "󰦖",
            done = "󰦕",
            error = "󱄊",
          },
        },
        show_request_summary = false,
      },
    },
  },
}
