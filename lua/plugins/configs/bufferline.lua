vim.cmd [[
" function! Toggle_theme(a,b,c,d)
"     lua require('base46').toggle_theme()
" endfunction

function! Quit_vim(a,b,c,d)
qa
endfunction
]]

require("bufferline").setup {
    options = {
        offsets = {
            { filetype = "NvimTree", text = "", padding = 1 },
            { filetype = "undotree", text = "", padding = 1 },
        },
        buffer_close_icon = "",
        mode = "buffers",
        modified_icon = "",
        close_icon = "",
        show_close_icon = false,
        left_trunc_marker = " ",
        right_trunc_marker = " ",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 18,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = "thin",
        always_show_bufferline = true,
        diagnostics = false,
        themable = true,

        custom_areas = {
            right = function()
                return {
                    -- { text = "%@Toggle_theme@" .. "" .. "%X" },
                    { text = "%@Quit_vim@  %X" },
                }
            end,
        },
        custom_filter = function(buf, buf_nums)
            local filetypes = { "vimwiki", "awk", "help" }

            for _, ft in ipairs(filetypes) do
                if vim.bo[buf].filetype == ft then
                    return false
                end
            end
            return true
        end,
    },
}
