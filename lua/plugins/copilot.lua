return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-Enter>",
          next = "<M-\\>",
          prev = "<M-S-\\>",
          dismiss = "<M-Backspace>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
      },
    },
  },
}
