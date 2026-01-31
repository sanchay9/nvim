vim.keymap.set("n", "<C-'>", function()
  vim.cmd "wa"

  local file_path = vim.fn.expand "%:p" -- Full path to the current file
  local file_dir = vim.fn.expand "%:h" -- Directory of the current file

  local compile_cmd = "pdflatex -output-directory "
    .. vim.fn.shellescape(file_dir)
    .. " "
    .. vim.fn.shellescape(file_path)
  vim.cmd("silent! !" .. compile_cmd)

  local dir = vim.fn.expand "%:p:h"
  local base = vim.fn.expand "%:t:r"
  for _, ext in ipairs { "log", "aux", "toc", "out" } do
    local file = dir .. "/" .. base .. "." .. ext
    vim.fn.delete(file)
  end

  local filename_base = vim.fn.expand "%:r"
  vim.ui.open(filename_base .. ".pdf")
end, { buffer = true })
