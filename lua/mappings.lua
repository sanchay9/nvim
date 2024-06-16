vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("n", "<C-w><C-w>", "<nop>")
vim.keymap.set("n", "<esc>", vim.cmd.noh)
-- vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader><tab>", "<C-^>")

vim.keymap.set("n", "[q", vim.cmd.cprev)
vim.keymap.set("n", "]q", vim.cmd.cnext)

vim.keymap.set("n", "[b", vim.cmd.bprev)
vim.keymap.set("n", "]b", vim.cmd.bnext)

vim.keymap.set({ "n", "x" }, "j", "v:count ? 'j' : 'gj'", { expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count ? 'k' : 'gk'", { expr = true })

vim.keymap.set("n", "<A-up>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<A-down>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<A-left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<A-right>", "<cmd>vertical resize +2<cr>")

vim.keymap.set("n", "<A-j>", ":m .+1<cr>==")
vim.keymap.set("n", "<A-k>", ":m .-2<cr>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv")

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "x" }, "<leader>p", [["0p]])

vim.keymap.set("n", "Q", "@q", { desc = "play macro recorded in q register" })
vim.keymap.set("n", "S", ":%s///g<Left><Left><Left>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<bs>", function()
  local buf = vim.api.nvim_get_current_buf()

  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 0 then -- Cancel
      return
    end
    if choice == 1 then -- Yes
      vim.cmd.write()
    end
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
        return
      end
      -- Try using alternate buffer
      local alt = vim.fn.bufnr "#"
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Try using previous buffer
      local has_previous = pcall(vim.cmd, "bprevious")
      if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
        return
      end

      -- Create new listed buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.cmd, "bdelete! " .. buf)
  end
end, { desc = "Delete Buffer" })
