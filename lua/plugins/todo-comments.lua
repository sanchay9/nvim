return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "todo trouble" },
    },
  },
}
