vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")
vim.keymap.set("n", "<leader><tab>", "<C-^>")

vim.keymap.set("n", "[q", vim.cmd.cprev)
vim.keymap.set("n", "]q", vim.cmd.cnext)

vim.keymap.set("n", "[b", vim.cmd.bprev)
vim.keymap.set("n", "]b", vim.cmd.bnext)

vim.keymap.set({ "n", "x" }, "j", "v:count ? 'j' : 'gj'", { expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count ? 'k' : 'gk'", { expr = true })

vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")
vim.keymap.set({ "n", "t" }, "<C-h>", "<cmd> wincmd h<cr>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<cmd> wincmd k<cr>")
vim.keymap.set("n", "<C-j>", "<cmd> wincmd j<cr>")
vim.keymap.set("n", "<C-l>", "<cmd> wincmd l<cr>")

vim.keymap.set("n", "<C-up>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<C-down>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<C-left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<C-right>", "<cmd>vertical resize +2<cr>")

vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==")
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv")

-- play the macro recorded in `@q`
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("n", "S", ":%s///g<Left><Left><Left>")
vim.keymap.set("n", "<leader>a", "ggVG")
vim.keymap.set("n", "<leader>,", "<cmd> wa | only | cd ~ | Alpha<cr>")
