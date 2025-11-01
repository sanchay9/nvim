return {
  "folke/zen-mode.nvim",
  keys = { { "<leader>Z", vim.cmd.ZenMode, desc = "toggle zenmode" } },
  dependencies = {
    "folke/twilight.nvim",
  },
  opts = {},
}
