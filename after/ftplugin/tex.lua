-- vim.keymap.set("n", "<C-'>", "<CMD> wa | !pdflatex %<CR><CR>", { buffer = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  buffer = 0,
  callback = function()
    vim.cmd "wa"
    vim.cmd "silent! !pdflatex %"
  end,
})
