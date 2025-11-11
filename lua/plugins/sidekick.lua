return {
  "folke/sidekick.nvim",
  opts = {
    nes = { enabled = true },
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
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
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
