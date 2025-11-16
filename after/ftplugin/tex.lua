vim.keymap.set("n", "<C-'>", function()
  vim.cmd "wa"
  vim.cmd "silent! !pdflatex %"

  local dir = vim.fn.expand "%:p:h"
  local base = vim.fn.expand "%:t:r"
  for _, ext in ipairs { "log", "aux", "toc", "out" } do
    local file = dir .. "/" .. base .. "." .. ext
    vim.fn.delete(file)
  end

  local filename_base = vim.fn.expand "%:r"
  vim.ui.open(filename_base .. ".pdf")
end, { buffer = true })
