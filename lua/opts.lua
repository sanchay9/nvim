vim.g.mapleader = " "

vim.opt.guifont = "Iosevka NF:h11"
vim.opt.fileencoding = "utf-8"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 -- spaces to use for indent
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.number = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers
vim.opt.wrap = false -- no line wrap
vim.opt.undofile = true -- persistant undo
vim.opt.scrolloff = 5
vim.opt.swapfile = false -- no swap files
vim.opt.clipboard = "unnamedplus" -- sync clipboard bw os and nvim
vim.opt.updatetime = 250 -- fast updates (default 4000)
vim.opt.timeoutlen = 400
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true -- case insensitive searching
vim.opt.smartcase = true -- when searching pattern with uppercase, case sensitive
vim.opt.wildmode = "longest:full,full" -- first tab shows longest
vim.opt.wildignore = "*.exe,*.ini" -- ignore files
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- hide -- INSERT --
vim.opt.cursorline = true
vim.opt.laststatus = 3 -- global statusline
vim.opt.linebreak = true
vim.opt.cmdheight = 0
vim.opt.smoothscroll = true
-- vim.opt.colorcolumn = "120"
vim.opt.shortmess:append "sI" -- disable nvim intro screen
vim.opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",

  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
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
    vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
  end
  return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end
vim.opt.foldexpr = "v:lua.foldexpr()"

vim.opt.statuscolumn = "%!v:lua.require'snacks.statuscolumn'.get()"

-- vim.opt.numberwidth = 2 -- set number column width (default 4)
-- vim.opt.signcolumn = "yes:2"
-- vim.opt.mousemodel = "extend"
-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

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
