return {
  {
    "folke/todo-comments.nvim",
    cmd = "TodoTrouble",
    opts = {},
    keys = {
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      {
        "<leader>st",
        function()
          require("todo-comments.fzf").todo()
        end,
        desc = "Todo",
      },
    },
  },
}
