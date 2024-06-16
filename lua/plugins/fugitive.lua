return {
  {
    "tpope/vim-fugitive",
    cmd = "G",
    keys = {
      { "<leader>gs", vim.cmd.Git, desc = "Git" },
      { "<leader>gd", "<cmd>Git diff<cr>", desc = "Git diff" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
      { "<leader>ga", "<cmd>Gwrite<cr>", desc = "Git add current file" },
      { "<leader>gl", "<cmd>0Gclog!<cr>", desc = "Navigate history" },
      { "<leader>gm", "<cmd>Gvdiffsplit!<cr>", desc = "show merge conflict" },
    },
  },
  --
  -- {
  --   "NeogitOrg/neogit",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "sindrets/diffview.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   keys = {
  --     { "<leader>gs", "<cmd>Neogit kind=split<cr>", desc = "Neogit" },
  --   },
  --   cmd = "Neogit",
  --   config = true,
  -- },
}
