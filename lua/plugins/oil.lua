return {
  {
    "stevearc/oil.nvim",
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "<leader>-", "<cmd>Oil --float<cr>", desc = "Open parent directory float" },
    },
    opts = {
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      win_options = {
        number = false,
        statuscolumn = " ",
      },
      float = {
        win_options = {
          winblend = 10,
        },
        override = function()
          return {
            border = "single",
            relative = "editor",
            height = vim.o.lines,
            width = math.max(25, math.ceil(vim.o.columns * 0.3)),
            row = 1,
            col = 1,
          }
        end,
      },
      keymaps = {
        ["?"] = "actions.show_help",
        ["<C-l>"] = false,
        ["<C-h>"] = false,
        ["<C-s>"] = false,
        ["<C-w><C-s>"] = "actions.select_split",
        ["<C-w><C-v>"] = "actions.select_vsplit",
        ["<C-p>"] = false,
        ["<leader>p"] = "actions.preview",
        ["-"] = "actions.open_cwd",
        ["<bs>"] = "actions.parent",
      },
    },
  },
}
