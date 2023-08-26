---- map leader to space
vim.g.mapleader = " "

local config = require("core.utils").load_config()

vim.g.curr_theme = config.ui.theme
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.toggle_theme_icon = "   "
vim.g.transparency = config.ui.transparency

-- add binaries installed by mason.nvim to path
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath "data" .. "/mason/bin"

vim.g.neovide_cursor_vfx_mode = "pixiedust"

vim.opt.statusline = "%!v:lua.require('statusline." .. require("core.utils").load_config().ui.statusline.theme .. "').run()"
vim.opt.guifont = "FiraCode Nerd Font:h11"
vim.opt.fileencoding = "utf-8"
vim.opt.ts = 4
vim.opt.sts = 4
vim.opt.shiftwidth = 4                          -- spaces to use for indent
vim.opt.expandtab = true                        -- use spaces instead of tabs
-- vim.opt.smartindent = true
vim.opt.number = true                           -- line numbers
vim.opt.wrap = false                            -- no line wrap
vim.opt.scrolloff = 4                           -- centered cursor
vim.opt.sidescrolloff = 4
vim.opt.undofile = true                         -- persistant undo
vim.opt.swapfile = false                        -- no swap files
vim.opt.clipboard = "unnamedplus"               -- enable copy paste
vim.opt.termguicolors = true
vim.opt.background = "dark"                     -- set background light/dark
vim.opt.updatetime = 250                        -- fast updates (default 4000)
vim.opt.timeoutlen = 400
vim.opt.splitright = true                       -- open splits right
vim.opt.splitbelow = true                       -- open splits below
vim.opt.ignorecase = true                       -- case insensitive searching
vim.opt.smartcase = true                        -- when searching pattern with uppercase, case sensitive
vim.opt.wildmode = 'longest:full,full'          -- first tab shows longest
vim.opt.wildignore = '*.exe,*.ini'              -- ignore files
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.laststatus = 3                          -- global statusline
-- vim.opt.cmdheight = 0
vim.opt.fillchars = { eob = " " }
vim.opt.shortmess:append "sI"                   -- disable nvim intro screen
vim.opt.numberwidth = 2                         -- set number column width (default 4)
vim.opt.signcolumn = "yes"
vim.opt.mousemodel = "extend"
-- vim.opt.statusline = "%!v:lua.require('statusline').run()"

-- vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.opt.foldcolumn = '1'
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
-- vim.opt.statuscolumn = "%=%l%s%C"
-- vim.opt.statuscolumn = '%{v:wrap ? repeat(" ", float2nr(ceil(log10(v:lnum))))."↳":v:lnum}%=%s%C'

for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
