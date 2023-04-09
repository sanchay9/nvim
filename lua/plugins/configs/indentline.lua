-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    -- char = "▏",  -- '▏', '┊', '|', '¦', '┆'
    filetype_exclude = {
        "awk",
        "dashboard",
        "vimwiki",
        "undotree",
        "help",
        "terminal",
        "alpha",
        "mason",
        "packer",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
    },
    buftype_exclude = { "terminal", "nofile" },
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = true,
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
}
