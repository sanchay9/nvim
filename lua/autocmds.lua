local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
--   group = augroup "term_enter",
--   callback = function()
--     vim.cmd.startinsert()
--     vim.opt_local.nu = false
--   end,
-- })

-- remember last position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup "last_loc",
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- open oil on directory
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = augroup "oil",
  callback = function(data)
    if vim.fn.isdirectory(data.file) == 1 then
      vim.cmd.cd(data.file)
      require("lazy").load { plugins = { "oil.nvim" } }
    end
  end,
})

-- open selected and close qf
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup "close_qf",
  pattern = "quickfix",
  command = [[nnoremap <buffer> <S-CR> <CR>:cclose<CR>]],
})

-- reload files
vim.api.nvim_create_autocmd({ "FocusGained", "TermLeave", "TermClose" }, {
  group = augroup "checktime",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd "checktime"
    end
  end,
})

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
-- vim.cmd [[ au InsertEnter * set norelativenumber ]]
-- vim.cmd [[ au InsertLeave * set relativenumber ]]

-- close ft with q
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "close_with_q",
  pattern = {
    "PlenaryTestPopup",
    "dashboard",
    "alpha",
    "Jaq",
    "notify",
    "qf",
    "help",
    "man",
    "checkhealth",
    "lspinfo",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  callback = function()
    vim.highlight.on_yank { higroup = "Cursor", timeout = 200 }
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup "resize_splits",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- don't add comment on enter/o/O on comment line
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup "no_comment",
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
})
