vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("n", "<C-w><C-w>", "<nop>")
vim.keymap.set("n", "<esc>", vim.cmd.noh)
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")
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
vim.keymap.set("n", "<leader>,", "<cmd>wa | only | cd ~ | Alpha<cr>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
