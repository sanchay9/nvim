require "options"
require "autocmds"
require "mappings"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)

require "plugins"
vim.cmd[[hi Comment gui=italic]]
vim.cmd[[hi WinSeparator guifg=black]]
vim.cmd[[hi AlphaHeader guifg=#7aa2f7]]
