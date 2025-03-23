local M = {}

---@param kind string
function M.pick(kind)
  return function()
    local actions = require "CopilotChat.actions"
    local items = actions[kind .. "_actions"]()
    if not items then
      return
    end
    return require("CopilotChat.integrations.fzflua").pick(items)
  end
end

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

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    opts = function()
      return {
        question_header = "  User ",
        answer_header = "  Copilot ",
        error_header = "> [!ERROR] Error",
        highlight_headers = false,
        show_help = false,
        insert_at_end = true,
        window = {
          width = 0.4,
          -- layout = "float",
          -- relative = "cursor",
          -- width = 1,
          -- height = 0.4,
          -- row = 1,
        },
      }
    end,
    keys = {
      {
        "<leader>at",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          local input = vim.fn.input "Quick Chat: "
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<leader>ap", "<cmd>CopilotChatPrompts<cr>", desc = "Copilot Chat Prompts", mode = { "n", "v" } },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })
      require("CopilotChat").setup(opts)
    end,
  },
}
