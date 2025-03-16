vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  group = vim.api.nvim_create_augroup("term_enter", { clear = true }),
  callback = function()
    -- vim.cmd.startinsert()
    vim.opt_local.nu = false
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "goto last position when opening buffer",
  group = vim.api.nvim_create_augroup("last_position", { clear = true }),
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
  group = vim.api.nvim_create_augroup("vim enter", { clear = true }),
  callback = function(data)
    if vim.fn.isdirectory(data.file) == 1 then
      vim.cmd.cd(data.file)
      require("oil").open(data.file)
      -- local fzf_lua = require "fzf-lua"
      -- fzf_lua.files { cwd = data.file }
    end

    if vim.fn.argc() > 0 or vim.fn.line2byte "$" ~= -1 or not vim.o.modifiable then
      return
    end

    for _, arg in pairs(vim.v.argv) do
      if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
        return
      end
    end
    require("alpha").start()
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermLeave", "TermClose" }, {
  desc = "reload files on events",
  group = vim.api.nvim_create_augroup("checktime", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd "checktime"
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "make it easier to close man-files when opened inline",
  group = vim.api.nvim_create_augroup("man_unlisted", { clear = true }),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "set wrap for text files",
  group = vim.api.nvim_create_augroup("wrap", { clear = true }),
  pattern = { "text", "plaintex", "http", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "auto create parent dir if doesn't exist on saving a file",
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match "^%w%w+:[\\/][\\/]" then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "InsertEnter" }, {
  desc = "toggle relativenumber on mode change",
  group = vim.api.nvim_create_augroup("toggle_relativenumber", { clear = true }),
  callback = function(event)
    if event.event == "InsertLeave" then
      vim.opt_local.relativenumber = true
    else
      vim.opt_local.relativenumber = false
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "close ft with q",
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
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
    "dap-repl",
    "dap-float",
    "fugitive",
    "fugitiveblame",
    "tsplayground",
    "startuptime",
    "neotest-summary",
    "neotest-output",
    "neotest-output-panel",
    "grug-far",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd "close"
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight on yank",
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.hl.on_yank { higroup = "Cursor", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc = "resize splits if window got resized",
  group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. current_tab)
  end,
})
