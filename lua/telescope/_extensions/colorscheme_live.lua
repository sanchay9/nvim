local present, telescope = pcall(require, "telescope")

if not present then
    error "telescope.nvim is not found"
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

local function enter(prompt_bufnr)
    local selection = action_state.get_selected_entry()

    vim.fn.jobstart("swcs " .. selection[1])

    require"colors".init(selection[1])
    -- vim.cmd[[luafile $HOME/.config/nvim/lua/plugins/configs/bufferline.lua]]

    actions.close(prompt_bufnr)
    if vim.bo.filetype == "alpha" or vim.bo.filetype == "dashboard" then
        vim.opt.laststatus = 0
        vim.opt.showtabline = 0
    end
end

local function next_color(prompt_bufnr)
    actions.move_selection_next(prompt_bufnr)
    local selection = action_state.get_selected_entry()

    require"colors".init(selection[1])
end

local function prev_color(prompt_bufnr)
    actions.move_selection_previous(prompt_bufnr)
    local selection = action_state.get_selected_entry()

    require"colors".init(selection[1])
end

local list_themes = function(return_type)
   local themes = {}
   -- folder where theme files are stored
   -- local themes_folder = vim.fn.stdpath "data" .. "/site/pack/packer/start/base46/lua/base46/themes"
   local themes_folder = vim.fn.stdpath "data" .. "/lazy/base46/lua/base46/themes"
   -- list all the contents of the folder and filter out files with .lua extension, then append to themes table
   local fd = vim.loop.fs_scandir(themes_folder)

   if fd then
      while true do
         local name, typ = vim.loop.fs_scandir_next(fd)

         if name == nil then
            break
         end

         if typ ~= "directory" and string.find(name, ".lua$") then
            -- return the table values as keys if specified
            if return_type == "keys_as_value" then
               themes[vim.fn.fnamemodify(name, ":r")] = true
            else
               table.insert(themes, vim.fn.fnamemodify(name, ":r"))
            end
         end
      end
   end

   return themes
end

local function colorscheme_live()
    pickers.new(require"telescope.themes".get_dropdown(), {
    -- pickers.new({
        prompt_title = "Select a Theme",
        prompt_prefix = "    ",
        finder = finders.new_table(list_themes()),
        sorter = sorters.get_generic_fuzzy_sorter({}),

        attach_mappings = function(prompt_bufnr, map)
            map("i", "<CR>", enter)
            map("i", "<C-n>", next_color)
            map("i", "<C-p>", prev_color)

            map("n", "<CR>", enter)
            map("n", "j", next_color)
            map("n", "k", prev_color)

            return true
        end,
    }):find()
end

return telescope.register_extension {
    exports = { colorscheme_live = colorscheme_live },
}
