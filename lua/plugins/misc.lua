return {
  {
    "zSnails/NeoNeedsKey",
    lazy = true,
    opts = {},
  },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
  },

  {
    "eandrju/cellular-automaton.nvim",
    keys = { { "<leader>z", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "make it rain" } },
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },

  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 5,
      show_count = false,
      position = "bottom-right",
    },
    dependencies = "nvzone/volt",
  },

  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  {
    "jackplus-xyz/player-one.nvim",
    cmd = "PlayerOneToggle",
    opts = {},
  },

  {
    "nvim-mini/mini.animate",
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs { "Up", "Down" } do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require "mini.animate"
      return {
        scroll = {
          timing = animate.gen_timing.linear { duration = 150, unit = "total" },
          subscroll = animate.gen_subscroll.equal {
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          },
        },
      }
    end,
  },
}
