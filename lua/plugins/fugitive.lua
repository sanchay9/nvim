return {
  cmd = "G",
  keys = {
    { "<leader>gs", vim.cmd.Git, desc = "Git" },
    { "<leader>gd", "<cmd>Git diff<cr>", desc = "Git diff" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
    { "<leader>ga", "<cmd>Gwrite<cr>", desc = "Git add current file" },
    { "<leader>gl", "<cmd>0Gclog!<cr>", desc = "Navigate history" },
    { "<leader>gm", "<cmd>Gvdiffsplit!<cr>", desc = "show merge conflict" },
  },
  "tpope/vim-fugitive",
}
