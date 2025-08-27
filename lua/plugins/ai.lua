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
          adapter = "gemini",
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
          adapter = "gemini",
          keymaps = {
            accept_change = {
              modes = {
                n = "<C-y>",
              },
              index = 1,
              callback = "keymaps.accept_change",
              description = "Accept change",
            },
            reject_change = {
              modes = {
                n = "<esc>",
              },
              index = 2,
              callback = "keymaps.reject_change",
              description = "Reject change",
            },
          },
        },
        cmd = {
          adapter = "gemini",
        },
      },
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                default = "gemini-2.5-pro",
              },
            },
          })
        end,
      },
      display = {
        diff = {
          provider = "mini_diff",
        },
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
