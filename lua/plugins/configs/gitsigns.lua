require "gitsigns".setup {
    signs = {
        add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
        change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
        delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
        topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
        changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
        untracked = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    },

    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local opts = { buffer = bufnr }

        -- Navigation through hunks
        vim.keymap.set('n', ']c', function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, buffer = bufnr })

        vim.keymap.set('n', '[c', function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, buffer = bufnr })

        -- Actions
        vim.keymap.set({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>', opts)
        vim.keymap.set({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>', opts)
        vim.keymap.set('n', '<leader>hp', gs.preview_hunk, opts)
        -- vim.keymap.set('n', '<leader>hS', gs.stage_buffer, opts)
        -- vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, opts)
        -- vim.keymap.set('n', '<leader>hR', gs.reset_buffer, opts)
        vim.keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end, opts)
        -- vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, opts)
        -- vim.keymap.set('n', '<leader>hd', gs.diffthis, opts)
        -- vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end, opts)
        vim.keymap.set('n', '<leader>td', gs.toggle_deleted, opts)
    end,
}
