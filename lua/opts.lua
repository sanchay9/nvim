vim.g.mapleader = " "

vim.g.border = "none" -- none / single / double / rounded / solid / shadow / { "╔", "═", "╗", "║", "╝", "═", "╚", "║" }

-- TODO: vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

vim.opt.guifont = "Iosevka NF:h11"
vim.opt.fileencoding = "utf-8"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 -- spaces to use for indent
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.number = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers
vim.opt.wrap = false -- no line wrap
vim.opt.undofile = true -- persistant undo
vim.opt.scrolloff = 5 -- lines of context
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.swapfile = false -- no swap files
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- sync with system clipboard
vim.opt.updatetime = 200 -- trigger cursorhold (default 4000)
vim.opt.timeoutlen = 300
vim.opt.virtualedit = "block" -- allow cursor to move where there is no text in visual block mode
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.ignorecase = true -- case insensitive searching
vim.opt.smartcase = true -- case sensitive when searching with uppercase
vim.opt.wildmode = "longest:full,full" -- first tab shows longest
vim.opt.wildignore = "*.exe,*.ini" -- ignore files
vim.opt.pumheight = 10 -- pop up max entries
vim.opt.ruler = false -- disable default ruler
vim.opt.pumblend = 10 -- pop up blend
vim.opt.showmode = false -- hide -- INSERT --
vim.opt.cursorline = true
vim.opt.laststatus = 3 -- global statusline
vim.opt.linebreak = true -- wrap lines at convenient points
vim.opt.cmdheight = 0
vim.opt.smoothscroll = true
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.completeopt = "menu,menuone,noselect"
-- vim.opt.colorcolumn = "120" -- highlight column for alignment
vim.opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",

  diff = "╱",
  eob = " ",
}
vim.opt.foldlevel = 99
vim.opt.foldtext = ""
vim.opt.foldmethod = "expr"
_G.foldexpr = function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].ts_folds == nil then
    if vim.bo[buf].filetype == "" then
      return "0"
    end
    if vim.bo[buf].filetype:find "dashboard" then
      vim.b[buf].ts_folds = false
    else
      vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
    end
  end
  return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end
vim.opt.foldexpr = "v:lua.foldexpr()"

vim.opt.formatoptions = "jcroqlnt"
vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

-- vim.opt.numberwidth = 12 -- set number column width (default 4)
vim.opt.signcolumn = "yes" -- always show sign column

vim.opt.list = true -- show invisible chars
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.opt.listchars:append "tab:»·"
-- vim.opt.listchars:append "trail:·"
-- vim.opt.listchars:append "extends:»"
-- vim.opt.listchars:append "precedes:«"
vim.opt.listchars:append "nbsp:␣"

vim.opt.shortmess:append { I = true, c = true, C = true }

-- vim.opt.diffopt = "internal,filler,closeoff,linematch:60"
vim.opt.diffopt = "filler,internal,closeoff,algorithm:histogram,context:5,linematch:60"

for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

vim.filetype.add {
  extension = {
    http = "http",
  },
  pattern = {
    [".*/waybar/config"] = "jsonc",
    [".*/kitty/.+%.conf"] = "sh",
    [".*/hypr/.+%.conf"] = "hyprlang",
    ["%.env%.[%w_.-]+"] = "sh",
  },
}
