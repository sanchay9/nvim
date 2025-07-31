return {
  "MagicDuck/grug-far.nvim",
  opts = { headerMaxWidth = 80 },
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").toggle_instance {
          instanceName = "far",
          staticTitle = "Find and Replace",
          transient = true,
        }
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
    {
      "S",
      function()
        require("grug-far").toggle_instance {
          instanceName = "far_buffer",
          staticTitle = "Find and Replace in Buffer",
          transient = true,
          prefills = { paths = vim.fn.expand "%:p" },
        }
      end,
      mode = { "n", "v" },
      desc = "Search and Replace in current buffer",
    },
  },
}
