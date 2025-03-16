return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "sindrets/diffview.nvim",
        keys = {
          {
            "<leader>dv",
            function()
              if next(require("diffview.lib").views) then
                vim.cmd "DiffviewClose"
              else
                vim.cmd "DiffviewOpen"
              end
            end,
            desc = "Toggle Diffview",
          },
          {
            "<leader>fh",
            "<cmd>DiffviewFileHistory --follow %<cr>",
            desc = "File History",
          },
          {
            "<leader>lh",
            "<cmd>.DiffviewFileHistory --follow<cr>",
            desc = "Line History",
          },
        },
        cmd = "DiffviewOpen",
        config = function()
          local actions = require "diffview.actions"
          require("diffview").setup {
            enhanced_diff_hl = true,
            show_help_hints = false,
            -- stylua: ignore
            keymaps = {
              view = {
                { "n", "?",     actions.help { "view", "diff1" },        { desc = "Open the help panel" } },
                { "n", "q",     function () vim.cmd "DiffviewClose" end, { desc = "Close Diffview" } },
                { "n", "<C-e>", actions.toggle_files,                    { desc = "Toggle the file panel." } },

                ["[F"] = false,
                ["]F"] = false,
                ["gf"] = false,
                ["g?"] = false,
                ["<C-w><C-f>"] = false,
                ["<C-w>gf"] = false,
                ["<leader>e"] = false,
                ["<leader>b"] = false,
                ["g<C-x>"] = false,
                ["<leader>cb"] = false,
                ["dx"] = false,
                ["<leader>cB"] = false,
                ["dX"] = false,
              },
              file_panel = {
                { "n", "?",     actions.help("file_panel"),              { desc = "Open the help panel" } },
                { "n", "q",     function () vim.cmd "DiffviewClose" end, { desc = "Close Diffview" } },
                { "n", "<C-e>", actions.toggle_files,                    { desc = "Toggle the file panel" } },

                ["o"] = false,
                ["-"] = false,
                ["s"] = false,
                ["S"] = false,
                ["U"] = false,
                ["X"] = false,
                ["<c-b>"] = false,
                ["<c-f>"] = false,
                ["[F"] = false,
                ["]F"] = false,
                ["gf"] = false,
                ["<C-w><C-f>"] = false,
                ["<C-w>gf"] = false,
                ["i"] = false,
                ["f"] = false,
                ["R"] = false,
                ["<leader>e"] = false,
                ["<leader>b"] = false,
                ["g<C-x>"] = false,
                ["[x"] = false,
                ["]x"] = false,
                ["g?"] = false,
                ["<leader>cO"] = false,
                ["<leader>cT"] = false,
                ["<leader>cB"] = false,
                ["<leader>cA"] = false,
                ["dX"] = false,
              },
            },
          }
        end,
      },
    },
    keys = {
      { "<leader>gs", "<cmd>Neogit<cr>", desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit Commit" },
      { "<leader>gb", "<cmd>Neogit branch<cr>", desc = "Neogit Branch" },
      { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Neogit Pull" },
      { "<leader>gP", "<cmd>Neogit push<cr>", desc = "Neogit Push" },
    },
    cmd = "Neogit",
    opts = {
      disable_hint = true,
      console_timeout = 5000,
      remember_settings = false,
      integrations = {
        diffview = true,
        fzf_lua = true,
      },
      commit_editor = {
        spell_check = false,
      },
      signs = {
        item = { "", "" },
        section = { "", "" },
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
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame_opts = {
        virt_text_pos = "right_align",
        delay = 100,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local opts = { buffer = bufnr }

        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gs.nav_hunk "next"
          end
        end, opts)

        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gs.nav_hunk "prev"
          end
        end, opts)

        vim.keymap.set({ "n", "v" }, "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", opts)
        vim.keymap.set({ "n", "v" }, "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", opts)
        vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts)
        vim.keymap.set("n", "<leader>he", gs.preview_hunk, opts)

        vim.keymap.set("n", "<leader>ge", function()
          gs.blame_line { full = true }
        end, opts)
        vim.keymap.set("n", "<leader>gB", gs.blame, opts)

        vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<cr>")
      end,
    },
  },
}
