return {
  {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
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
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local opts = { buffer = bufnr }

        -- Navigation through hunks
        vim.keymap.set("n", "]h", function()
          if vim.wo.diff then
            return "]h"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr })

        vim.keymap.set("n", "[h", function()
          if vim.wo.diff then
            return "[h"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr })

        -- Actions
        vim.keymap.set({ "n", "v" }, "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", opts)
        vim.keymap.set({ "n", "v" }, "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", opts)
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
        -- vim.keymap.set('n', '<leader>hS', gs.stage_buffer, opts)
        -- vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, opts)
        -- vim.keymap.set('n', '<leader>hR', gs.reset_buffer, opts)
        vim.keymap.set("n", "<leader>hb", function()
          gs.blame_line { full = true }
        end, opts)
        -- vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, opts)
        -- vim.keymap.set('n', '<leader>hd', gs.diffthis, opts)
        -- vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end, opts)
        -- vim.keymap.set("n", "<leader>td", gs.toggle_deleted, opts)
      end,
    },
  },
}
