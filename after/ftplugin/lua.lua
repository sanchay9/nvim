vim.keymap.set("n", "<C-'>", "<CMD> wa | luafile %<CR>", { buffer = true })
vim.keymap.set("n", "<C-S-'>", "<CMD> wa | .lua<CR>", { buffer = true })
