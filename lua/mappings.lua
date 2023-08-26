-- do nothing on space
vim.keymap.set('', '<Space>', '<Nop>')

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

vim.keymap.set('n', '<leader>a', 'ggVG')
vim.keymap.set('n', '<leader>n', 'gg"_dG<CMD> 0r ~/code/Codes/templatesingle.cpp | wa | :15<CR>i    ')
vim.keymap.set('n', '<leader>m', 'gg"_dG<CMD> 0r ~/code/Codes/templatemulti.cpp | wa | :13<CR>i    ')
vim.keymap.set('n', '<leader>,', '<CMD> wa | cd ~ | Alpha<CR>')
vim.keymap.set('n', '<C-n>', '<CMD> NvimTreeToggle<CR>')
-- vim.keymap.set('n', '<leader>m', '<CMD> MinimapToggle<CR>')
vim.keymap.set('n', '<leader>d', '<CMD> MarkdownPreviewToggle<CR>')

vim.keymap.set('n', '<leader>o', '<CMD> setlocal spell! spelllang=en_us<CR>')

vim.keymap.set('n', 'Q', '@q')

vim.keymap.set('n', '<Esc>', '<CMD>noh<CR>', {silent = true})

vim.keymap.set('n', 'S', ':%s///g<Left><Left><Left>')

-- vim.keymap.set('n', '<F1>', '<CMD> hi Normal guibg=none | hi  LineNr guibg=none | hi clear CursorLine<CR>', {noremap = true})

vim.keymap.set('n', '<leader>u', '<CMD> UndotreeToggle<CR>')
vim.keymap.set('n', 'gx', '<CMD>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>')

vim.keymap.set('n', '<leader>t', "<CMD> Telescope colorscheme_live<CR>")
vim.keymap.set('n', '<leader>ff', "<CMD> Telescope find_files<CR>")
vim.keymap.set('n', '<leader>fg', "<CMD> Telescope live_grep<CR>")
vim.keymap.set('n', '<leader>fb', "<CMD> Telescope buffers<CR>")
vim.keymap.set('n', '<leader>fh', "<CMD> Telescope help_tags<CR>")
vim.keymap.set('n', '<leader>/', "<CMD> lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, })<CR>")
-- vim.keymap.set('n', '<leader>z', ":lua require('telescope').extensions.file_browser.file_browser( { grouped = true } )<CR>")
vim.keymap.set('n', '<leader>fc', ":lua require'telescope.builtin'.symbols{ sources = {'gitmoji'} }<CR>", {silent = true})
vim.keymap.set('n', '<leader>f.', ":lua require'telescope.builtin'.symbols{ sources = {'nerd'} }<CR>")

-- map('i', '{', '{}<Left>')
-- vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O')
-- map('i', '{{', '{')
-- map('i', '{}', '{}')

---- abbreviations
vim.cmd.iabbrev "<silent> idt Date: <C-R>=strftime('%c')<CR>"

vim.api.nvim_create_user_command("H", function()
    vim.cmd "Telescope help_tags"
end, {})
