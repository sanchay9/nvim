return {
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>gs", "<cmd>Neogit kind=split<cr>", desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit Commit" },
      { "<leader>gb", "<cmd>Neogit branch<cr>", desc = "Neogit Branch" },
      { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Neogit Pull" },
      { "<leader>gP", "<cmd>Neogit push<cr>", desc = "Neogit Push" },
    },
    cmd = "Neogit",
    opts = {
      integrations = {
        diffview = true,
        fzf_lua = true,
        auto_close_console = false,
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    cmd = "Gitsigns",
    init = function()
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    opts = {
      signs = {
        -- add = { text = "▎" }, --│
        -- change = { text = "▎" },
        delete = { text = "" }, -- 
        topdelete = { text = "" }, -- ‾
        changedelete = { text = "~" },
        untracked = { text = "▎" },
      },
      current_line_blame_opts = {
        virt_text_pos = "right_align",
        delay = 100,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local opts = { buffer = bufnr }

        vim.keymap.set("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal { "]h", bang = true }
          else
            gs.nav_hunk "next"
          end
        end, opts)

        vim.keymap.set("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal { "[h", bang = true }
          else
            gs.nav_hunk "prev"
          end
        end, opts)

        vim.keymap.set({ "n", "v" }, "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", opts)
        vim.keymap.set({ "n", "v" }, "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", opts)
        vim.keymap.set("n", "<leader>he", gs.preview_hunk, opts)
        vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts)

        vim.keymap.set("n", "<leader>ge", function()
          gs.blame_line { full = true }
        end, opts)
        vim.keymap.set("n", "<leader>gB", gs.blame, opts)
        vim.keymap.set("n", "<leader>gt", gs.toggle_current_line_blame, opts)

        vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<cr>")
      end,
    },
  },
}
