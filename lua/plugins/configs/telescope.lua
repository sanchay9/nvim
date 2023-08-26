require "telescope".setup {
    defaults = {
        mappings = {
            i = {
                ["<leader><CR>"] = function(prompt_bufnr)
                    local selected_entry = require('telescope.actions.state').get_selected_entry()
                    local filename = vim.fn.fnameescape(vim.fn.fnamemodify(selected_entry[1], ':t'))
                    local filename_wo_timestamp = filename:match("[^/\\]+$"):gsub("^%d+%-?(.-)%.%w+$", "%1")
                    filename_wo_timestamp = string.gsub(filename_wo_timestamp, "_", " ")

                    local mdlink = "[" .. filename_wo_timestamp .. "](" .. filename .. ")"
                    require('telescope.actions').close(prompt_bufnr)
                    vim.api.nvim_put({mdlink}, "", false, true)
                end
            },
            n = {
                ["<leader><CR>"] = function(prompt_bufnr)
                    local selected_entry = require('telescope.actions.state').get_selected_entry()
                    local filename = vim.fn.fnameescape(vim.fn.fnamemodify(selected_entry[1], ':t'))
                    local filename_wo_timestamp = filename:match("[^/\\]+$"):gsub("^%d+%-?(.-)%.%w+$", "%1")
                    filename_wo_timestamp = string.gsub(filename_wo_timestamp, "_", " ")

                    local mdlink = "[" .. filename_wo_timestamp .. "](" .. filename .. ")"
                    require('telescope.actions').close(prompt_bufnr)
                    vim.api.nvim_put({mdlink}, "", false, true)
                end
            },
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
        -- prompt_prefix = "   ",
        prompt_prefix = "    ",
        -- prompt_prefix = "    ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
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
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        project = {
            theme = "dropdown",
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = true, -- default false
        },
        file_browser = {
            theme = "ivy",
            hijack_netrw = true,
        },
    },
}

require'telescope'.load_extension('fzf')
require'telescope'.load_extension('colorscheme_live')
require'telescope'.load_extension('project')
require'telescope'.load_extension('file_browser')
