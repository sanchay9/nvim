vim.opt_local.wrap = true
vim.opt_local.nu = false
vim.opt_local.rnu = false
vim.opt_local.modeline = false

vim.keymap.set("n", "<tab>", "<cmd>call search('\\[[^]]*\\]([^)]\\+)')<cr>", { buffer = true })
vim.keymap.set("n", "<s-tab>", "<cmd>call search('\\[[^]]*\\]([^)]\\+)', 'b')<cr>", { buffer = true })
