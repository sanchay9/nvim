return {
  {
    "olimorris/codecompanion.nvim",
    keys = {
      {
        "<leader>A",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "CodeCompanion Chat",
        mode = { "n", "v" },
      },
      {
        "<leader>ar",
        "<cmd>CodeCompanion<cr>",
        desc = "CodeCompanion",
        mode = { "n", "v" },
      },
      {
        "<leader>aa",
        "<cmd>CodeCompanionActions<cr>",
        desc = "CodeCompanion Actions",
        mode = { "n", "v" },
      },
    },
    opts = {
      opts = {
        job_start_delay = 1500, -- Delay in milliseconds between cmd tools
        submit_delay = 100, -- Delay in milliseconds before auto-submitting the chat buffer
        system_prompt = function()
          -- TODO: https://github.com/PickleBoxer/dev-chatgpt-prompts?tab=readme-ov-file#-modernizing-old-code
          return require("prompts")["codecompanion_default"]
        end,
      },
      strategies = {
        chat = {
          adapter = "copilot",
          roles = {
            llm = "",
            user = "",
          },
          keymaps = {
            clear = {
              modes = {
                n = "<C-l>",
              },
              index = 6,
              callback = "keymaps.clear",
              description = "Clear Chat",
            },
          },
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
      },
      adapters = {
        http = {
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              schema = {
                model = {
                  default = "gemini-2.5-flash",
                },
              },
            })
          end,
        },
      },
      display = {
        action_palette = {
          prompt = "",
        },
        chat = {
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
            opts = {
              number = false,
              relativenumber = false,
            },
          },
        },
      },
    },
  },
}
