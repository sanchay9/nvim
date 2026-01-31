return {
  "folke/sidekick.nvim",
  opts = {
    nes = { enabled = true, diff = { inline = false } },
    cli = {
      win = { layout = "right" },
      mux = {
        backend = "zellij",
        enabled = true,
      },
    },
    prompts = {
      changes = "Can you review my changes?",
      diagnostics = "Can you help me fix the diagnostics in {file}?\n{diagnostics}",
      diagnostics_all = "Can you help me fix these diagnostics?\n{diagnostics_all}",
      document = "Add documentation to {function|line}",
      explain = "Explain {this}",
      fix = "Can you fix {this}?",
      optimize = "How can {this} be optimized?",
      review = "Can you review {file} for any issues or improvements?",
      tests = "Can you write tests for {this}?",
      -- simple context prompts
      buffers = "{buffers}",
      file = "{file}",
      line = "{line}",
      position = "{position}",
      quickfix = "{quickfix}",
      selection = "{selection}",
      ["function"] = "{function}",
      class = "{class}",
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
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle",
      mode = { "n", "x", "t" },
    },
    {
      "<leader>ca",
      function()
        require("sidekick.cli").send { msg = "{this}" }
      end,
      mode = { "x" },
      desc = "Send This",
    },
    {
      "<leader>ca",
      function()
        require("sidekick.cli").send { msg = "{file}" }
      end,
      mode = { "n" },
      desc = "Send File",
    },
    {
      "<leader>cp",
      function()
        require("sidekick.cli").prompt { name = "opencode" }
      end,
      desc = "Sidekick Select Prompt",
      mode = { "n", "x" },
    },
  },
}
