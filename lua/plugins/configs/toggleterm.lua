require("toggleterm").setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = false,
    shade_filetypes = {},
    highlights = {
        -- Normal = {
        --     guibg = <VALUE-HERE>,
        -- },
        NormalFloat = {
            link = 'NvimTreeNormal'
        },
        -- FloatBorder = {
        --     guifg = require'colors'.get().darker_black,
        --     guibg = require'colors'.get().darker_black,
        -- },
    },
    shade_terminals = true,
    shading_factor = 1,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = false,
    shell = vim.o.shell,
    float_opts = {
        border = "single",
        winblend = 3,
        width = 160,
        height = 30,
    },
    -- on_open = fun(t: Terminal), -- function to run when the terminal opens
    -- on_close = fun(t: Terminal), -- function to run when the terminal closes
    -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
    -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
    -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
})
