vim.opt_local.wrap = true
vim.opt_local.number = false
vim.opt_local.modeline = false
vim.opt_local.conceallevel = 3

-- if vim.loop.cwd() == vim.loop.os_homedir() .. "/docs/notes" then
--   vim.opt.showtabline = 0
-- end

vim.cmd.iabbrev "<silent> idt Date: <C-R>=strftime('%c')<CR>"

---@diagnostic disable: param-type-mismatch
vim.keymap.set("n", "<leader>z", function()
  local win = require("plenary.popup").create("", {
    title = "Add Zettel",
    style = "minimal",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    relative = "cursor",
    borderhighlight = "RenamerBorder",
    titlehighlight = "RenamerTitle",
    focusable = true,
    width = 25,
    height = 1,
    line = "cursor+2",
    col = "cursor-1",
  })

  vim.cmd "normal w"
  vim.cmd "startinsert"

  vim.keymap.set({ "i", "n" }, "<CR>", function()
    local input = vim.trim(vim.fn.getline ".")
    if #input > 0 then
      vim.cmd "stopinsert"
      vim.api.nvim_win_close(win, true)

      -- TODO: Maybe ask "Add a link as well?"
      local filepath = "~/docs/notes/" .. os.date "%Y%m%d" .. "_" .. input .. ".md"
      local filename = vim.fn.fnameescape(vim.fn.fnamemodify(filepath, ":t"))
      local filename_wo_timestamp = filename:match("[^/\\]+$"):gsub("^%d+%_?(._)%.%w+$", "%1")
      filename_wo_timestamp = string.gsub(filename_wo_timestamp, "_", " ")
      local mdlink = "[" .. filename_wo_timestamp .. "](" .. filename .. ")"
      vim.api.nvim_put({ mdlink }, "", false, true)
      vim.api.nvim_command(":e " .. filepath)
    end
  end, { buffer = true })
  vim.keymap.set({ "i", "n" }, "<ESC>", "<cmd>stopinsert | q!<CR>", { buffer = true })
end)

---@diagnostic disable: param-type-mismatch
vim.keymap.set("n", "<CR>", function()
  local line = vim.fn.getline "."
  local cur = vim.api.nvim_win_get_cursor(0)

  for i = cur[2] + 1, #line - 1 do
    if string.sub(line, i, i + 1) == "](" then
      vim.api.nvim_win_set_cursor(0, { cur[1], cur[2] + i - cur[2] + 1 })
      if vim.fn.expand "<cfile>:e" == "md" then
        vim.api.nvim_feedkeys("gf", "n", false)
      else
        vim.cmd "call jobstart(['xdg-open', expand('<cfile>:p')], {'detach': v:true})"
      end
      return
    elseif i ~= cur[2] + 1 and string.sub(line, i, i) == "[" then
      break
    end
  end

  for i = cur[2] + 1, 2, -1 do
    if string.sub(line, i - 1, i) == "](" then
      vim.api.nvim_win_set_cursor(0, { cur[1], i })
      if vim.fn.expand "<cfile>:e" == "md" then
        vim.api.nvim_feedkeys("gf", "n", false)
      else
        vim.cmd "call jobstart(['xdg-open', expand('<cfile>:p')], {'detach': v:true})"
      end
      return
    elseif i ~= cur[2] + 1 and string.sub(line, i, i) == ")" then
      break
    end
  end
end, { buffer = true })
vim.keymap.set("n", "<BS>", function()
  if vim.fn.bufname "%" ~= "index.md" then
    vim.cmd "bd"
  end
end, { buffer = true })

-- vim.cmd[[syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal]]
-- vim.cmd[[syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends]]

vim.keymap.set("n", "<Tab>", "<Cmd>call search('\\[[^]]*\\]([^)]\\+)')<CR>", { buffer = true })
vim.keymap.set("n", "<S-Tab>", "<Cmd>call search('\\[[^]]*\\]([^)]\\+)', 'b')<CR>", { buffer = true })
