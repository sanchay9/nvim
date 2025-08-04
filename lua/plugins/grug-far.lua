return {
  "MagicDuck/grug-far.nvim",
  opts = {
    startInInsertMode = false,
    keymaps = {
      replace = { n = "<C-'>" },
    },
  },
  keys = {
    {
      "<leader>F",
      function()
        require("grug-far").toggle_instance {
          instanceName = "far",
          staticTitle = "Find and Replace",
          transient = true,
          prefills = { paths = vim.fn.expand "%:p" },
        }
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
}
