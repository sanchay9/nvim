return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoFzfLua" },
    opts = {},
    keys = {
      { "<leader>td", "<cmd>TodoFzfLua<cr>", desc = "Todo" },
    },
  },
}
