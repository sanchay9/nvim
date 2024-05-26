local function get_term_id()
  local term_id
  for _, chan in pairs(vim.api.nvim_list_chans()) do
    if chan["mode"] == "terminal" and chan["pty"] ~= "" then
      term_id = chan["id"]
      break
    end
  end

  if not term_id then
    vim.cmd "vert bo split | wincmd = | set nonu | term"
    vim.cmd "wincmd h"

    for _, chan in pairs(vim.api.nvim_list_chans()) do
      if chan["mode"] == "terminal" and chan["pty"] ~= "" then
        term_id = chan["id"]
        break
      end
    end
  end
  return term_id
end

vim.keymap.set("n", "<C-'>", function()
  vim.cmd "wa"
  vim.api.nvim_chan_send(get_term_id(), "clear; go run " .. vim.fn.expand "%" .. "\n")
end, { buffer = true })

vim.keymap.set("n", "<leader>i", function()
  if vim.fn.bufloaded(vim.fn.expand "~" .. "/code/lab/input") == 0 then
    vim.cmd [[sp ~/code/lab/input | resize 15 | vs ~/code/lab/output | wincmd k]]
    -- vim.cmd [[vs ~/code/lab/input | vertical resize 80 | set winfixwidth | sp ~/code/lab/output | wincmd h]]
  else
    vim.cmd [[wa | bunload input output]]
  end

  print " "
end, { buffer = true })

-- don't add comment on enter/o/O on comment line
-- vim.opt_local.formatoptions:remove "o"
