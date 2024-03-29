return {
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Nvim Tree" } },
    config = function()
      local function my_on_attach(bufnr)
        local api = require "nvim-tree.api"
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts "Up")
        vim.keymap.set("n", "?", api.tree.toggle_help, opts "Help")
      end

      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function(data)
          if vim.fn.isdirectory(data.file) == 1 then
            vim.cmd.cd(data.file)
            require("nvim-tree.api").tree.open()
          end
        end,
      })

      require("nvim-tree").setup {
        filters = {
          dotfiles = false,
        },
        on_attach = my_on_attach,
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        view = {
          adaptive_size = false,
          side = "left",
          width = 35,
          preserve_window_proportions = true,
        },
        git = {
          enable = true,
          ignore = true,
        },
        filesystem_watchers = {
          enable = true,
        },
        actions = {
          open_file = {
            resize_window = true,
          },
        },
        renderer = {
          highlight_git = false,
          highlight_opened_files = "none",
          -- root_folder_label = table.concat { ":t:gs? $?/..", string.rep(" ", 1000), "?:gs?^??" },
          -- root_folder_label = ":t",
          root_folder_label = false,

          indent_markers = {
            enable = true,
          },

          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = false,
            },

            glyphs = {
              default = "",
              symlink = "",
              folder = {
                default = "",
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
                symlink_open = "",
                arrow_open = "",
                arrow_closed = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
      }
    end,
  },
  {
    "stevearc/oil.nvim",
    keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent directory" } },
    opts = {
      keymaps = {
        ["?"] = "actions.show_help",
        ["<C-h>"] = "actions.toggle_hidden",
        ["<C-x>"] = "actions.select_split",
        ["<C-s>"] = "actions.select_vsplit",
        ["<esc>"] = "actions.close",
        ["-"] = "actions.open_cwd",
        ["<bs>"] = "actions.parent",
      },
    },
  },
}
