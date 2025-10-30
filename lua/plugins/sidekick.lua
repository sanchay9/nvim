return {
  "folke/sidekick.nvim",
  opts = {
    nes = { enabled = false },
    cli = {
      win = { layout = "float" },
      mux = {
        backend = "zellij",
        enabled = true,
      },
    },
  },
  keys = {
    {
      "<leader>C",
      function()
        require("sidekick.cli").toggle { name = "gemini" }
      end,
      desc = "Sidekick Claude Toggle",
      mode = { "n", "v", "x", "t" },
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      desc = "Sidekick Ask Prompt",
      mode = { "n", "v" },
    },
  },
}
