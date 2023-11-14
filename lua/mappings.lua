vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>", { silent = true })

vim.keymap.set("n", "<C-h>", "<cmd> wincmd h<cr>")
vim.keymap.set("n", "<C-j>", "<cmd> wincmd j<cr>")
vim.keymap.set("n", "<C-k>", "<cmd> wincmd k<cr>")
vim.keymap.set("n", "<C-l>", "<cmd> wincmd l<cr>")

vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-W>h")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-W>k")
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")

-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<C-up>", ":resize -2<cr>", { silent = true })
vim.keymap.set("n", "<C-down>", ":resize +2<cr>", { silent = true })
vim.keymap.set("n", "<C-left>", ":vertical resize -2<cr>", { silent = true })
vim.keymap.set("n", "<C-right>", ":vertical resize +2<cr>", { silent = true })

vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move text down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move text up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move text down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move text up" })

vim.keymap.set("n", "Q", "@q")
vim.keymap.set("n", "S", ":%s///g<Left><Left><Left>")
vim.keymap.set("n", "<leader>a", "ggVG")
vim.keymap.set("n", "<leader>,", "<cmd> wa | cd ~ | Alpha<cr>")
-- TODO: write in lua
vim.keymap.set("n", "gx", '<cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<cr>')
