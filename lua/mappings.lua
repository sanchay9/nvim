-- do nothing on space
vim.keymap.set('', '<Space>', '<Nop>')

vim.keymap.set('n', '<C-\'>', "<CMD> wa | TermExec cmd='runcpp %'<CR>")

vim.keymap.set('n', '<leader>c', function()
    local ok, start = require("indent_blankline.utils").get_current_context(
        vim.g.indent_blankline_context_patterns,
        vim.g.indent_blankline_use_treesitter_scope
    )

    if ok then
        vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
        vim.cmd [[normal! _]]
    end
end)

vim.keymap.set('n', '<leader>i', function()
    local path = vim.fn.expand("~")

    if vim.fn.bufloaded(path .. "/code/Input") == 0 then
        vim.cmd[[vs ~/code/Input | vertical resize 50 | set winfixwidth | sp ~/code/Output | wincmd h]]
    else
        vim.cmd[[wa | bd Input Output]]
    end

    print(" ")
end)

vim.keymap.set('n', '<C-h>', "<CMD> wincmd h<CR>")
vim.keymap.set('n', '<C-j>', "<CMD> wincmd j<CR>")
vim.keymap.set('n', '<C-k>', "<CMD> wincmd k<CR>")
vim.keymap.set('n', '<C-l>', "<CMD> wincmd l<CR>")
vim.keymap.set('t', '<C-h>', "<C-\\><C-n><C-W>h")
vim.keymap.set('t', '<C-k>', "<C-\\><C-n><C-W>k")
-- vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')

vim.keymap.set('n', '<S-h>', '<CMD> BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<S-l>', '<CMD> BufferLineCycleNext<CR>')

vim.keymap.set('n', '<C-u>', "<C-u>zz")
vim.keymap.set('n', '<C-d>', "<C-d>zz")

vim.keymap.set('n', '<C-Up>', ":resize -2<CR>", {silent = true})
vim.keymap.set('n', '<C-Down>', ":resize +2<CR>", {silent = true})
vim.keymap.set('n', '<C-Left>', ":vertical resize -2<CR>", {silent = true})
vim.keymap.set('n', '<C-Right>', ":vertical resize +2<CR>", {silent = true})

vim.keymap.set('n', '<A-k>', ":m -2<CR>==")
vim.keymap.set('n', '<A-j>', ":m +1<CR>==")
vim.keymap.set('n', '<A-h>', "<<")
vim.keymap.set('n', '<A-l>', ">>")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-h>', "<gv")
vim.keymap.set('v', '<A-l>', ">gv")

vim.keymap.set('n', '<leader>1', '<CMD> wa | cd ~/code | e A.cpp | %bd | e# | bd#<CR><CR>')
vim.keymap.set('n', '<leader>2', '<CMD> wa | cd ~/code | e B.cpp | %bd | e# | bd#<CR><CR>')
vim.keymap.set('n', '<leader>3', '<CMD> wa | cd ~/code | e C.cpp | %bd | e# | bd#<CR><CR>')
vim.keymap.set('n', '<leader>4', '<CMD> wa | cd ~/code | e D.cpp | %bd | e# | bd#<CR><CR>')
vim.keymap.set('n', '<leader>5', '<CMD> wa | cd ~/code | e E.cpp | %bd | e# | bd#<CR><CR>')

vim.keymap.set('n', '<leader>a', 'ggVG')
vim.keymap.set('n', '<leader>n', 'gg"_dG<CMD> 0r ~/code/Codes/templatesingle.cpp | wa | :15<CR>i    ')
vim.keymap.set('n', '<leader>m', 'gg"_dG<CMD> 0r ~/code/Codes/templatemulti.cpp | wa | :13<CR>i    ')
vim.keymap.set('n', '<leader>,', '<CMD> wa | cd ~ | Alpha<CR>')
vim.keymap.set('n', '<C-n>', '<CMD> NvimTreeToggle<CR>')
-- vim.keymap.set('n', '<leader>m', '<CMD> MinimapToggle<CR>')
vim.keymap.set('n', '<leader>d', '<CMD> MarkdownPreviewToggle<CR>')

-- vim.keymap.set('n', '<leader>o', '<CMD> setlocal spell! spelllang=en_us<CR>')

vim.keymap.set('n', 'Q', '@q')

vim.keymap.set('n', '<Esc>', ':noh<CR>', {silent = true})

vim.keymap.set('n', 'S', ':%s///g<Left><Left><Left>')

-- vim.keymap.set('n', '<F1>', '<CMD> hi Normal guibg=none | hi  LineNr guibg=none | hi clear CursorLine<CR>', {noremap = true})

vim.keymap.set('n', '<leader>u', '<CMD> UndotreeToggle<CR>')
vim.keymap.set('n', 'gx', '<CMD>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>')

vim.keymap.set('n', '<leader>t', "<CMD> Telescope colorscheme_live<CR>")
vim.keymap.set('n', '<leader>f', "<CMD> Telescope find_files<CR>")
vim.keymap.set('n', '<leader>g', "<CMD> Telescope live_grep<CR>")
vim.keymap.set('n', '<leader>b', "<CMD> Telescope buffers<CR>")
vim.keymap.set('n', '<leader>/', ":lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, })<CR>")
-- vim.keymap.set('n', '<leader>z', ":lua require('telescope').extensions.file_browser.file_browser( { grouped = true } )<CR>")
-- vim.keymap.set('n', '<leader>z', ":lua require'telescope.builtin'.symbols{ sources = {'gitmoji'} }<CR>")

-- keymap

-- map('i', '{', '{}<Left>')
-- vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O')
-- map('i', '{{', '{')
-- map('i', '{}', '{}')

---- abbreviations
vim.cmd [[iabbrev itn int]]
vim.cmd [[iabbrev icn cin]]
vim.cmd [[iabbrev cotu cout]]
vim.cmd [[iabbrev endl '\n']]
vim.cmd.iabbrev "<silent> idt Date: <C-R>=strftime('%c')<CR>"
vim.cmd.iabbrev "#! #!/usr/bin/env bash"
