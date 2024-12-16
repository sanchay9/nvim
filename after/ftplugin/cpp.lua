vim.opt_local.foldmethod = "marker"
vim.opt_local.foldmarker = "#ifdef LOCAL,#endif"
vim.opt_local.foldmarker = "#include <bits/stdc++.h>,#endif"

vim.cmd.iabbrev { "<buffer>", "itn", "int" }
vim.cmd.iabbrev { "<buffer>", "icn", "cin" }
vim.cmd.iabbrev { "<buffer>", "cotu", "cout" }
vim.cmd.iabbrev { "<buffer>", "endl", "'\\n'" }
vim.cmd.iabbrev { "<buffer>", "vi", "vector<int>" }
vim.cmd.iabbrev { "<buffer>", "vvi", "vector<vector<int>>" }
vim.cmd.iabbrev { "<buffer>", "vvvi", "vector<vector<vector<int>>>" }
vim.cmd.iabbrev { "<buffer>", "vpi", "vector<pair<int, int>>" }
vim.cmd.iabbrev { "<buffer>", "pii", "pair<int, int>" }
vim.cmd.iabbrev { "<buffer>", "yes", 'cout << "YES\\n";' }
vim.cmd.iabbrev { "<buffer>", "no", 'cout << "NO\\n";' }

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
  vim.api.nvim_chan_send(
    get_term_id(),
    "clear; ch samples " .. vim.fn.expand "%:t:r" .. " " .. vim.api.nvim_get_vvar "servername" .. "\n"
  )
end, { buffer = true })

vim.keymap.set("n", "<C-S-'>", function()
  vim.cmd "wa"
  vim.api.nvim_chan_send(
    get_term_id(),
    "clear; ch run " .. vim.fn.expand "%:t:r" .. " " .. vim.api.nvim_get_vvar "servername" .. "\n"
  )
end, { buffer = true })

vim.keymap.set("n", "<leader>n", 'gg"_dG<CMD> 0r ~/code/template/templatesingle.cpp | :9<CR>i    ', { buffer = true })
vim.keymap.set("n", "<leader>m", 'gg"_dG<CMD> 0r ~/code/template/templatemulti.cpp | :6<CR>i    ', { buffer = true })

-- for i = 1, 5 do
--   vim.keymap.set(
--     "n",
--     "<leader>" .. i,
--     string.format("<CMD> wa | cd ~/code/lab | e %s.cpp | %%bd | e# | bd#<CR><CR>", string.char(96 + i)),
--     { buffer = true }
--   )
-- end

vim.keymap.set("n", "<leader>i", function()
  if vim.fn.bufloaded(vim.fn.expand "~" .. "/code/bin/input") == 0 then
    vim.cmd [[sp ~/code/bin/input | resize 15 | vs ~/code/bin/output | wincmd k]]
    -- vim.cmd [[vs ~/code/bin/input | vertical resize 80 | set winfixwidth | sp ~/code/bin/output | wincmd h]]
  else
    vim.cmd [[wa | bunload input output]]
  end

  print " "
end, { buffer = true })
