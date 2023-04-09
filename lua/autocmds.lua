-- vim.cmd[[autocmd Filetype cpp setlocal foldmarker=using\ ll,#endif foldmethod=marker]]
-- vim.cmd[[autocmd Filetype zsh setlocal filetype=sh]]

-- remember last position
vim.cmd[[autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'| exe "normal! g`\""| endif]]

-- remove trailing whitespaces and nl on save
vim.cmd[[autocmd BufWritePre * %s/\s\+$//e]]
vim.cmd[[autocmd BufWritePre * %s/\n\+\%$//e]]

-- reload files
vim.api.nvim_create_autocmd({ "FocusGained", "TermLeave", "BufWinEnter" }, {
    pattern = { "*" },
    callback = function()
        vim.cmd "checktime"
    end,
})

-- augroup AutoSaveFolds
--   autocmd!
--   autocmd BufWinLeave * mkview
--   autocmd BufWinEnter * silent loadview
-- augroup END

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
-- vim.cmd[[ au InsertEnter * set norelativenumber ]]
-- vim.cmd[[ au InsertLeave * set relativenumber ]]

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "dashboard", "alpha", "Jaq", "qf", "man", "lspinfo", "spectre_panel", "lir", "DressingSelect", "tsplayground", "startuptime" },
    callback = function()
        vim.cmd [[
        nnoremap <silent> <buffer> q :q<CR>
        set nobuflisted
        ]]
    end,
})

vim.cmd[[autocmd FileType help,man nnoremap <silent> <buffer> f <C-w>o]]

-- highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank { higroup = "Cursor", timeout = 200 }
    end,
})

-- vim.api.nvim_create_autocmd({ "VimResized" }, {
--     callback = function()
--         vim.cmd "tabdo wincmd ="
--     end,
-- })

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.cmd "set formatoptions-=cro"
    end,
})

vim.api.nvim_create_autocmd('RecordingEnter', {
    callback = function()
        vim.opt_local.cmdheight = 1
    end,
})

vim.api.nvim_create_autocmd('RecordingLeave', {
    callback = function()
        local timer = vim.loop.new_timer()
        -- NOTE: Timer is here because we need to close cmdheight AFTER
        -- the macro is ended, not during the Leave event
        timer:start(
            50,
            0,
            vim.schedule_wrap(function()
                vim.opt_local.cmdheight = 0
            end)
        )
    end,
})

-- vim.cmd[[autocmd FileType alpha set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2]]
-- vim.cmd[[autocmd FileType vimwiki set cmdheight=1 | autocmd BufUnload <buffer> set cmdheight=0]]

-- hide statusbar
-- vim.cmd[[autocmd BufEnter,BufRead,BufWinEnter,FileType,WinEnter * lua function hide_st() local hidden = { "NvimTree" } local buftype = vim.api.nvim_buf_get_option(0, "ft") if vim.tbl_contains(hidden, buftype) then vim.api.nvim_set_option("laststatus", 0) return end vim.api.nvim_set_option("laststatus", 2) end hide_st()]]
-- vim.api.nvim_create_autocmd({ "User" }, {
--     pattern = { "AlphaReady" },
--     callback = function()
--         vim.cmd [[
--         set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
--         ]]
--     end,
-- })

-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" }, {
--     callback = function()
--         require("plugins.winbar").get_winbar()
--     end,
-- })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
        vim.api.nvim_create_autocmd("BufUnload", {
            buffer = 0,
            callback = function()
                vim.opt.laststatus = 3
                vim.opt.showtabline = 2
            end,
        })

        vim.opt.laststatus = 0
        vim.opt.showtabline = 0
        vim.opt.cmdheight = 0
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "vimwiki",
    callback = function()
        vim.cmd[[cd ~/docs/vimwiki]]
        vim.opt.cmdheight = 1
        vim.opt.showtabline = 0
    end,
})

-- vim.api.nvim_create_autocmd({ "BufWinEnter", "BufReadPre", "BufNewFile" }, {
--     pattern = "*",
--     callback = function()
--         -- if vim.bo.filetype == "vimwiki" then
--         --     vim.opt.cmdheight = 1
--         -- else
--         --     vim.opt.cmdheight = 0
--         -- end

--         if vim.bo.filetype == "alpha" then
--             return
--         end

--         vim.opt.laststatus = 3
--         vim.opt.showtabline = 2
--     end,
-- })

-- local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- -- Disable the statusline, tabline and cmdline while the alpha dashboard is open
-- autocmd('User', {
--   pattern = 'AlphaReady',
--   desc = 'disable status, tabline and cmdline for alpha',
--   callback = function()
-- 	  vim.go.laststatus = 0
--           vim.opt.showtabline = 0
-- 	  vim.opt.cmdheight = 0
--   end,
--   })
-- autocmd('BufUnload', {
--   buffer = 0,
--   desc = 'enable status, tabline and cmdline after alpha',
--   callback = function()
--           vim.go.laststatus = 2
--           vim.opt.showtabline = 2
-- 	  vim.opt.cmdheight = 1
--   end,
--   })

-- vim.api.nvim_create_autocmd("BufWritePost", {
--     callback = function(opts)
--         dofile(vim.g.base46_cache .. "devicons")
--         local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r") --[[@as string]]
--         local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
--         local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")

--         require("plenary.reload").reload_module "base46"
--         require("plenary.reload").reload_module(module)

--         local config = require("core.utils").load_config()

--         vim.g.curr_theme = config.ui.theme
--         vim.g.transparency = config.ui.transparency

--         -- statusline
--         require("plenary.reload").reload_module("statusline." .. config.ui.statusline.theme)
--         vim.opt.statusline = "%!v:lua.require('statusline." .. config.ui.statusline.theme .. "').run()"

--         require("base46").load_all_highlights()
--         -- vim.cmd("redraw!")
--     end,
-- })
