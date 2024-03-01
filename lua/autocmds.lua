-- remember last position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function(data)
    if vim.fn.isdirectory(data.file) == 1 then
      vim.cmd.cd(data.file)
      require("lazy").load { plugins = { "oil.nvim" } }
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "quickfix",
  command = [[nnoremap <buffer> <S-CR> <CR>:cclose<CR>]],
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermLeave", "TermClose" }, {
  pattern = "*",
  command = "checktime",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  callback = function()
    vim.cmd.startinsert()
  end,
})

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
-- vim.cmd [[ au InsertEnter * set norelativenumber ]]
-- vim.cmd [[ au InsertLeave * set relativenumber ]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "dashboard",
    "alpha",
    "Jaq",
    "qf",
    "help",
    "man",
    "lspinfo",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "startuptime",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :q<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "Cursor", timeout = 200 }
  end,
})

-- vim.api.nvim_create_autocmd({ "VimResized" }, {
--     callback = function()
--         vim.cmd "tabdo wincmd ="
--     end,
-- })

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "alpha",
--     callback = function()
--         vim.api.nvim_create_autocmd("BufUnload", {
--             buffer = 0,
--             callback = function()
--                 vim.opt.laststatus = 3
--                 vim.opt.showtabline = 0
--                 vim.opt.cmdheight = 0
--             end,
--         })

--         vim.opt.laststatus = 0
--         vim.opt.showtabline = 0
--         vim.opt.cmdheight = 0
--     end,
-- })
