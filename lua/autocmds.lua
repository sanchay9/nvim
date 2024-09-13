local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then
      return
    end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function()
    io.write "\027]111\027\\"
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  group = augroup "term_enter",
  callback = function()
    -- vim.cmd.startinsert()
    vim.opt_local.nu = false
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "remember last position",
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

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  desc = "open oil on directory, alpha on no args",
  group = augroup "vim enter",
  callback = function(data)
    if vim.fn.isdirectory(data.file) == 1 then
      vim.cmd.cd(data.file)
      require("oil").open(data.file)
    else
      if vim.fn.argc() > 0 or vim.fn.line2byte "$" ~= -1 or not vim.o.modifiable then
        return
      end

      for _, arg in pairs(vim.v.argv) do
        if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
          return
        end
      end
      require("alpha").start()
    end
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermLeave", "TermClose" }, {
  desc = "reload files on events",
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

vim.api.nvim_create_autocmd("FileType", {
  desc = "close ft with q",
  group = augroup "close_with_q",
  pattern = {
    "gitsigns-blame",
    "PlenaryTestPopup",
    "dashboard",
    "Jaq",
    "notify",
    "qf",
    "help",
    "man",
    "checkhealth",
    "lspinfo",
    "spectre_panel",
    "DressingSelect",
    "dap-repl",
    "dap-float",
    "fugitive",
    "fugitiveblame",
    "tsplayground",
    "startuptime",
    "neotest-summary",
    "neotest-output",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight on yank",
  group = augroup "highlight_yank",
  callback = function()
    vim.highlight.on_yank { higroup = "Cursor", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc = "resize splits if window got resized",
  group = augroup "resize_splits",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. current_tab)
  end,
})
