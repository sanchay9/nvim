return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoFzfLua" },
    opts = {},
    keys = {
      { "<leader>t", "<cmd>TodoFzfLua<cr>", desc = "Todo" },
    },
  },
}
