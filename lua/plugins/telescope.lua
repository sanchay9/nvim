return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            {
                "nvim-telescope/telescope-file-browser.nvim",
                config = function()
                    require("telescope").load_extension "file_browser"
                end,
            },
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
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>f:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
            { "<leader>`", "<cmd>Telescope notify<cr>", desc = "Notifs" },
            {
                "<leader>f.",
                "<cmd>lua require'telescope.builtin'.symbols{ sources = {'nerd'} }<cr>",
                desc = "Nerd Font Symbols",
            },
            {
                "<leader>/",
                "<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, })<cr>",
                desc = "Fuzzy Search",
            },
            {
                "<leader>fe",
                "<cmd>lua require('telescope').extensions.file_browser.file_browser( { grouped = true } )<cr>",
                desc = "File Browser",
            },
            {
                "<leader>fc",
                "<cmd>lua require'telescope.builtin'.symbols{ sources = {'gitmoji'} }<cr>",
                desc = "Commit Symbols",
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
                -- prompt_prefix = "   ",
                prompt_prefix = "    ",
                -- prompt_prefix = "    ",
                selection_caret = "  ",
                entry_prefix = "  ",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                file_ignore_patterns = { "node_modules" },
                path_display = { "truncate" },
                winblend = 0,
                border = {},
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
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
                    file_browser = {
                        theme = "ivy",
                        hijack_netrw = true,
                    },
                },
            },
        },
    },
}
