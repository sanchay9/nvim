return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
    {
      "<leader>gx",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
  },
  opts = {
    quickfile = { enabled = true },
    words = { enabled = true },
  },
}
