vim.opt_local.wrap = true
vim.opt_local.number = false
vim.opt_local.modeline = false
vim.opt_local.conceallevel = 2

vim.cmd.iabbrev "<silent> idt Date: <C-R>=strftime('%c')<cr>"

-- ---@diagnostic disable: param-type-mismatch
-- vim.keymap.set("n", "<CR>", function()
--   local line = vim.fn.getline "."
--   local cur = vim.api.nvim_win_get_cursor(0)
--
--   for i = cur[2] + 1, #line - 1 do
--     if string.sub(line, i, i + 1) == "](" then
--       vim.api.nvim_win_set_cursor(0, { cur[1], cur[2] + i - cur[2] + 1 })
--       if vim.fn.expand "<cfile>:e" == "md" then
--         vim.api.nvim_feedkeys("gf", "n", false)
--       else
--         vim.api.nvim_feedkeys("gx", "n", false)
--       end
--       return
--     elseif i ~= cur[2] + 1 and string.sub(line, i, i) == "[" then
--       break
--     end
--   end
--
--   for i = cur[2] + 1, 2, -1 do
--     if string.sub(line, i - 1, i) == "](" then
--       vim.api.nvim_win_set_cursor(0, { cur[1], i })
--       if vim.fn.expand "<cfile>:e" == "md" then
--         vim.api.nvim_feedkeys("gf", "n", false)
--       else
--         vim.api.nvim_feedkeys("gx", "n", false)
--       end
--       return
--     elseif i ~= cur[2] + 1 and string.sub(line, i, i) == ")" then
--       break
--     end
--   end
-- end, { buffer = true })

-- vim.keymap.set("n", "<BS>", function()
--   if vim.fn.bufname "%" ~= "index.md" then
--     vim.cmd "bd"
--   end
-- end, { buffer = true })

vim.keymap.set("n", "<tab>", "<cmd>call search('\\[[^]]*\\]([^)]\\+)')<cr>", { buffer = true })
vim.keymap.set("n", "<s-tab>", "<cmd>call search('\\[[^]]*\\]([^)]\\+)', 'b')<cr>", { buffer = true })
