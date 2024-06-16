local function on_load(name, fn)
  local Config = require "lazy.core.config"
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    enabled = false,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = vim.fn.executable "make" == 1 and "make",
        config = function(plugin)
          on_load("telescope.nvim", function()
            local ok, err = pcall(require("telescope").load_extension, "fzf")
            if not ok then
              local lib = plugin.dir .. "/build/libfzf.so"
              if not vim.uv.fs_stat(lib) then
                vim.notify "`telescope-fzf-native.nvim` not built. Rebuilding..."
                require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
                  vim.notify "Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim."
                end)
              else
                vim.notify("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
              end
            end
          end)
        end,
      },
      "nvim-telescope/telescope-symbols.nvim",
    },
    keys = {
      { "<leader>ff", "<cmd>lua require'telescope.builtin'.find_files()<cr>", desc = "Find Files" },
      {
        "<leader>f.",
        "<cmd>lua require'telescope.builtin'.find_files({ cwd = vim.fn.expand('%:p:h') })<cr>",
        desc = "Find Files in cwd",
      },
      { "<leader>gg", "<cmd>lua require'telescope.builtin'.live_grep()<cr>", desc = "Grep" },
      {
        "<leader>g.",
        "<cmd>lua require'telescope.builtin'.live_grep({ cwd = vim.fn.expand('%:p:h') })<cr>",
        desc = "Grep in cwd",
      },
      { "<leader>r", "<cmd>lua require'telescope.builtin'.oldfiles()<cr>", desc = "Recent" },
      { "<leader>`", "<cmd>Telescope notify<cr>", desc = "Notifs" },
      {
        "<leader>b",
        "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown { previewer = false, })<cr>",
        desc = "Buffers",
      },
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
    config = function()
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<leader>p"] = require("telescope.actions.layout").toggle_preview,
              ["<C-s>"] = "file_split",
            },
            n = {
              ["<leader>p"] = require("telescope.actions.layout").toggle_preview,
              ["<C-s>"] = "file_split",
            },
          },
          preview = {
            hide_on_startup = true,
          },
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
            width = 0.70,
            height = 0.65,
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
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case",
            },
          },
        },
      }
    end,
  },
}
