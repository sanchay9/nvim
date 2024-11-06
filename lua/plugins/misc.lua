return {
  {
    "zSnails/NeoNeedsKey",
    lazy = true,
    opts = {},
  },
  {
    "eandrju/cellular-automaton.nvim",
    keys = { { "<leader>z", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "make it rain" } },
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 5,
      show_count = false,
      position = "bottom-right",
    },
    dependencies = { "NvChad/volt" },
  },
}
