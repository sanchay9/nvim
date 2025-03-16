vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("n", "<C-w><C-w>", "<nop>")

vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
  vim.cmd.noh()
  -- TODO: LazyVim.cmp.actions.snippet_stop()
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

for _, char in ipairs { ",", ".", ";" } do
  vim.keymap.set("i", char, char .. "<c-g>u", { desc = "add undo break-point on " .. char })
end

vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { desc = "exit terminal mode" })
vim.keymap.set("n", "<leader><tab>", "<C-^>", { desc = "switch to alternate buffer" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "previous quickfix item" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "next quickfix item" })

vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

vim.keymap.set("n", "<leader>qt", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Toggle Quickfix List" })

vim.keymap.set("n", "<C-up>", "<cmd>resize +2<cr>", { desc = "increase window height" })
vim.keymap.set("n", "<C-down>", "<cmd>resize -2<cr>", { desc = "decrease window height" })
vim.keymap.set("n", "<C-left>", "<cmd>vertical resize -2<cr>", { desc = "decrease window width" })
vim.keymap.set("n", "<C-right>", "<cmd>vertical resize +2<cr>", { desc = "increase window width" })

vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "move lines down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "move lines up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "move lines down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "move lines up" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete without yanking" })
vim.keymap.set({ "n", "x" }, "<leader>p", [["0p]], { desc = "paste from 0 register" })

vim.keymap.set("n", "Q", "@q", { desc = "play macro recorded in q register" })
vim.keymap.set("n", "S", ":%s///g<Left><Left><Left>")

vim.keymap.set("n", "<bs>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader><bs>", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

vim.keymap.set("n", "<leader>\\", function()
  Snacks.terminal()
end, { desc = "Terminal (cwd)" })
vim.keymap.set("t", "<leader>\\", "<cmd>close<cr>", { desc = "Hide Terminal" })
