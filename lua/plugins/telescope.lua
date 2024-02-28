return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension "fzf"
        end,
      },
      "nvim-telescope/telescope-symbols.nvim",
    },
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>r", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>h", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>`", "<cmd>Telescope notify<cr>", desc = "Notifs" },
      {
        "<leader><esc>",
        "<cmd>lua require'telescope.builtin'.resume()<cr>",
        desc = "Resume last prompt",
      },
      {
        "<leader>.",
        "<cmd>lua require'telescope.builtin'.symbols{ sources = {'nerd'} }<cr>",
        desc = "Nerd Font Symbols",
      },
      {
        "<leader>/",
        "<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { previewer = false, })<cr>",
        desc = "Fuzzy Search",
      },
    },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        -- prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.50,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          -- width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_ignore_patterns = { "node_modules", "^vendor/" },
        path_display = { "truncate" },
        winblend = 7,
        border = {},
        -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        pickers = {
          buffers = {
            -- ignore_current_buffer = true,
            sort_lastused = true,
            sort_mru = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      },
    },
  },
}
