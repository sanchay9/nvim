vim.opt_local.nu = false
vim.opt_local.rnu = false
vim.opt_local.modeline = false

vim.keymap.set("n", "<CR>", vim.lsp.buf.definition, { buffer = true })
