return {
  {
    "zSnails/NeoNeedsKey",
    lazy = true,
    opts = {},
  },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
  },

  {
    "eandrju/cellular-automaton.nvim",
    keys = { { "<leader>z", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "make it rain" } },
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
    dependencies = "nvzone/volt",
  },

  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  {
    "jackplus-xyz/player-one.nvim",
    cmd = "PlayerOneToggle",
    opts = {},
  },
}
