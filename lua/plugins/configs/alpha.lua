-- vim.notify("Hello There, and Welcome to Neovim", 'off', { title = 'Neovim' })
local db = require'alpha.themes.dashboard'

db.section.header.opts.hl = "AlphaHeader"
db.section.footer.opts.hl = "AlphaFooter"

-- local term_height = 10
-- require "alpha.term"
-- db.section.header = {
--     type = "terminal",
--     -- command = "cat | lolcat -F 0.3 " .. os.getenv("HOME") .. "/.config/nvim/lua/banners/neovim.cat",
--     command = "neo --fps=20 --speed=5 -D -m 'NEO VIM' -d 0.5 -l 1,1",
--     width = 60,
--     height = term_height,
--     opts = {
--         redraw = true,
--         window_config = {},
--     },
-- }
db.section.header.val = require("banners").pacman
-- db.section.footer.val = require("alpha.fortune")
-- db.section.footer.val = "  Neovim loaded " .. require("lazy").stats().count .. " plugins"
db.section.footer.val = {
    os.date("  %d/%m/%Y ") .. "  " .. require("lazy").stats().count .. " plugins " .. "  v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
}

db.section.buttons.val = {
    --          
    -- db.button( 'p',   '  Practice',    ":cd ~/code | e A.cpp<CR>" ),
    db.button( 'w',   '  VimWiki',     ":VimwikiIndex<CR>" ),
    db.button( 'r',   '  Recents',     ":Telescope oldfiles<CR>" ),
    db.button( 'p',   '  Projects',    ":lua require'telescope'.extensions.project.project{}<CR>" ),
    db.button( 'b',   '  Bookmarks',   ":Telescope bookmarks<CR>" ),
    db.button( 'c',   '  Config',      ":cd ~/.config/nvim/ | Telescope fd<CR>" ),
    db.button( 't',   '  Theme',       ":Telescope colorscheme_live<CR>" ),
    -- db.button( 'v',   '  VimBeGood',   ":VimBeGood<CR>" ),
}

db.config.layout = {
    { type = "padding", val = 2 },
    db.section.header,
    -- { type = "padding", val = term_height + 7 },
    { type = "padding", val = 2 },
    db.section.buttons,
    { type = "padding", val = 2 },
    db.section.footer,
}

require("alpha").setup(db.opts)
