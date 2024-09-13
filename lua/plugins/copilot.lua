return {
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    config = function()
      require("copilot").setup {
        suggestion = {
          auto_trigger = false,
          keymap = {
            accept = "<M-Enter>",
            next = "<M-\\>",
            prev = "<M-S-\\>",
            dismiss = "<M-Backspace>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
        },
      }
    end,
  },
}
