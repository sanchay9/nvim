require("nvim-autopairs").setup({
    check_ts = true,
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
    },
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
})

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
