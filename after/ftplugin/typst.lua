vim.keymap.set("n", "<C-'>", function()
  vim.cmd.vsp()
  vim.cmd "vertical resize 20"
  vim.cmd("term typst watch " .. vim.fn.shellescape(vim.fn.expand "%:"))
  vim.cmd.wincmd "h"
end, {
  buffer = true,
  desc = "Watch current file",
})

vim.keymap.set("n", "<leader>P", function()
  local pdf_path = vim.fn.shellescape(vim.fn.expand "%:p:r" .. ".pdf")
  vim.cmd("silent !zathura --fork " .. pdf_path .. " &")
end, {
  buffer = true,
  desc = "Refresh PDF view",
})
